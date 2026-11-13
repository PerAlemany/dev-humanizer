#!/usr/bin/env bash
# Builds a repo with a distinctive house style: plain-sentence commit
# subjects, a money() helper for every amount, a project exception and
# %-formatted error messages. Used by the house-style test cases.
# Usage: make-styled-repo.sh <target-dir> <variant>
#   base    the history only
#   commit  base plus a staged change letting vat_for accept credit notes
set -eu
T="$1"; V="$2"
case "$V" in base|commit) ;; *) echo "unknown variant: $V" >&2; exit 2 ;; esac
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
mkdir -p "$T" && cd "$T"
git init -q -b main
git config user.name "Ana Ruiz"; git config user.email "ana@example.com"
mkdir -p invoices tests
: > invoices/__init__.py
cat > invoices/money.py <<'X'
from decimal import Decimal, ROUND_HALF_UP

CENT = Decimal("0.01")


def money(value):
    return Decimal(str(value)).quantize(CENT, rounding=ROUND_HALF_UP)
X
cat > invoices/errors.py <<'X'
class InvoiceError(Exception):
    pass
X
cat > invoices/tax.py <<'X'
from invoices.errors import InvoiceError
from invoices.money import money

VAT_RATE = money("0.21")


def vat_for(amount):
    if money(amount) < 0:
        raise InvoiceError("negative amount: %s" % amount)
    return money(money(amount) * VAT_RATE)
X
cat > README.md <<'X'
# invoice-api

Issues and lists invoices. Every amount goes through `money()`.
X
git add -A && git commit -q -m "Start the invoice service"
cat > invoices/queries.py <<'X'
def list_invoices(db):
    return db.query("select * from invoices order by issued_at desc")
X
git add -A && git commit -q -m "Add the invoice listing"
cat > invoices/queries.py <<'X'
def list_invoices(db):
    return db.query("select * from invoices where deleted_at is null order by issued_at desc")
X
git add -A && git commit -q -m "Hide soft-deleted invoices from the listing (#398)"
cat > tests/test_tax.py <<'X'
from invoices.tax import vat_for


def test_vat_basic():
    assert vat_for(100) == vat_for("100.00")


def test_vat_zero():
    assert vat_for(0) == 0
X
git add -A && git commit -q -m "Cover zero amounts in the VAT tests"
git commit -q --allow-empty -m "Explain money() in the README"
if [ "$V" = commit ]; then
# Credit notes have negative amounts, so vat_for has to accept them.
cat > invoices/tax.py <<'X'
from invoices.money import money

VAT_RATE = money("0.21")


def vat_for(amount):
    return money(money(amount) * VAT_RATE)
X
cat >> tests/test_tax.py <<'X'


def test_vat_credit_note():
    assert vat_for(-100) == -vat_for(100)
X
git add -A
fi
