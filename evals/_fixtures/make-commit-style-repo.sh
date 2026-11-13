#!/usr/bin/env bash
# Builds a repo whose commit history is written in a casual, human style,
# with a staged change ready to commit. Used by the commit-style cases.
# Usage: make-commit-style-repo.sh <target-dir> <es|en>
set -eu
T="$1"; L="$2"
case "$L" in es|en) ;; *) echo "unknown language: $L" >&2; exit 2 ;; esac
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
mkdir -p "$T" && cd "$T"
git init -q -b main
git config user.name "Ana Ruiz"; git config user.email "ana@example.com"
mkdir -p invoices tests
: > invoices/__init__.py
cat > invoices/tax.py <<'X'
VAT_RATE = 0.21


def vat_for(amount):
    if amount < 0:
        raise ValueError("negative amount: %s" % amount)
    return round(amount * VAT_RATE, 2)
X
c() { git add -A && git commit -q -m "$1"; }
if [ "$L" = es ]; then m1="primera versión del servicio"; m2="listado de facturas"; m3="el listado ya no enseña las facturas borradas (#398)"; m4="tests para importes a cero"; m5="explico el redondeo en el README"
else m1="first version of the service"; m2="invoice listing"; m3="listing no longer shows deleted invoices (#398)"; m4="tests for zero amounts"; m5="explain rounding in the README"; fi
c "$m1"
echo 'def list_invoices(db):
    return db.query("select * from invoices order by issued_at desc")' > invoices/queries.py; c "$m2"
echo 'def list_invoices(db):
    return db.query("select * from invoices where deleted_at is null order by issued_at desc")' > invoices/queries.py; c "$m3"
printf 'from invoices.tax import vat_for\n\n\ndef test_vat_zero():\n    assert vat_for(0) == 0\n' > tests/test_tax.py; c "$m4"
printf '# invoice-api\n\nAmounts are rounded to cents with round().\n' > README.md; c "$m5"
cat > invoices/tax.py <<'X'
VAT_RATE = 0.21


def vat_for(amount):
    return round(amount * VAT_RATE, 2)
X
printf '\n\ndef test_vat_credit_note():\n    assert vat_for(-100) == -21.0\n' >> tests/test_tax.py
git add -A
