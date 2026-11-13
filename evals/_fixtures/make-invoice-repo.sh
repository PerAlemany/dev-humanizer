#!/usr/bin/env bash
# Builds the small git repo the repository test cases run against.
# Usage: make-invoice-repo.sh <target-dir> <variant>
#   base    the initial history only
#   commit  base plus a staged change to invoices/tax.py
#   pr      base plus a feat/csv-export branch with two commits
set -eu
T="$1"; V="$2"
case "$V" in base|commit|pr) ;; *) echo "unknown variant: $V" >&2; exit 2 ;; esac
# Ignore the caller's global git config (signing, hooks) so the fixture builds anywhere.
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
mkdir -p "$T" && cd "$T"
git init -q -b main
git config user.name "Ana Ruiz"; git config user.email "ana@example.com"
mkdir -p invoices tests .github
cat > AGENTS.md <<'X'
# Contributor notes

- Commits follow Conventional Commits with a scope: `type(scope): subject`.
- Keep the subject under 60 characters, lowercase, no trailing period.
- If the change closes an issue, end the subject with `(#<number>)`.
- Bodies are optional; use them to explain *why*, not *what*.
X
cat > .github/pull_request_template.md <<'X'
## What

## Why

## How to test
X
cat > invoices/__init__.py <<'X'
X
cat > invoices/tax.py <<'X'
VAT_RATE = 0.21


def vat_for(amount):
    return round(amount * VAT_RATE, 2)


def total_with_vat(amount):
    return round(amount + vat_for(amount), 2)
X
cat > tests/test_tax.py <<'X'
from invoices.tax import vat_for


def test_vat_basic():
    assert vat_for(100) == 21.0
X
git add -A && git commit -q -m "chore(repo): initial project layout"
cat > invoices/queries.py <<'X'
def list_invoices(db):
    return db.query("select * from invoices order by issued_at desc")


def get_invoice(db, number):
    return db.query("select * from invoices where number = %s", (number,))
X
git add -A && git commit -q -m "feat(invoices): add invoice listing query"
echo '# invoice-api

Small service that issues and lists invoices.' > README.md
git add -A && git commit -q -m "docs(readme): describe the service"
perl -pi -e 's/from invoices order by issued_at desc/from invoices where deleted_at is null order by issued_at desc/' invoices/queries.py
git add -A && git commit -q -m "fix(invoices): hide soft-deleted invoices from listing (#398)" -m "Soft-deleted rows were still showing up in the customer portal."
echo 'def test_vat_zero():
    from invoices.tax import vat_for
    assert vat_for(0) == 0' >> tests/test_tax.py
git add -A && git commit -q -m "test(tax): cover zero amount"

if [ "$V" = commit ]; then
cat > invoices/tax.py <<'X'
from decimal import Decimal, ROUND_HALF_UP

VAT_RATE = Decimal("0.21")
CENT = Decimal("0.01")


def vat_for(amount):
    amount = Decimal(str(amount))
    return (amount * VAT_RATE).quantize(CENT, rounding=ROUND_HALF_UP)


def total_with_vat(amount):
    amount = Decimal(str(amount))
    return (amount + vat_for(amount)).quantize(CENT, rounding=ROUND_HALF_UP)
X
cat >> tests/test_tax.py <<'X'


def test_vat_rounds_half_up():
    from decimal import Decimal
    # 0.125 * 0.21 used to come out as 0.03 or 0.02 depending on float error
    assert vat_for("10.05") == Decimal("2.11")
X
git add -A
fi

if [ "$V" = pr ]; then
git checkout -q -b feat/csv-export
cat > invoices/export.py <<'X'
import csv
import io

COLUMNS = ["number", "customer", "issued_at", "net", "vat", "total"]


def invoices_to_csv(rows):
    buf = io.StringIO()
    writer = csv.DictWriter(buf, fieldnames=COLUMNS, extrasaction="ignore")
    writer.writeheader()
    for row in rows:
        writer.writerow(row)
    return buf.getvalue()
X
git add -A && git commit -q -m "feat(export): add csv export for invoices"
cat > tests/test_export.py <<'X'
from invoices.export import invoices_to_csv


def test_header_only_when_empty():
    assert invoices_to_csv([]).strip() == "number,customer,issued_at,net,vat,total"
X
perl -pi -e 's/extrasaction="ignore"/extrasaction="ignore", lineterminator="\\n"/' invoices/export.py
git add -A && git commit -q -m "fix(export): use unix line endings so excel on mac opens it" -m "Accounting reported blank rows between invoices on macOS (#421)."
fi
