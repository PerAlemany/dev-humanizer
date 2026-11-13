#!/usr/bin/env bash
# Builds a repo with a plain-sentence commit history (one commit has a body
# that explains why) and one small staged change whose subject line says
# everything. Used by the README commit examples: the agent makes a real
# commit and the whole message is quoted.
# Usage: make-small-change-repo.sh <target-dir> <es|en> <timeout|typo|unused>
#   timeout  TaxClient timeout goes from 5 to 30 and retries from 0 to 2
#   typo     fixes a misspelled word in a user-facing error message
#   unused   removes a function nothing calls
set -eu
T="$1"; L="$2"; V="$3"
case "$L" in es|en) ;; *) echo "unknown language: $L" >&2; exit 2 ;; esac
case "$V" in timeout|typo|unused) ;; *) echo "unknown variant: $V" >&2; exit 2 ;; esac
# Ignore the caller's global git config (signing, hooks, templates) so the fixture builds anywhere.
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
mkdir -p "$T" && cd "$T"
git init -q -b main
git config user.name "Ana Ruiz"; git config user.email "ana@example.com"
git config commit.gpgsign false

if [ "$L" = es ]; then
  m1="Primera versión del servicio de facturas"
  m2="Añade el cliente del servicio de impuestos"
  m3="Quita las facturas borradas del listado (#398)"
  b3="Seguían saliendo en el portal de clientes."
  m4="Añade pruebas para importes a cero"
  m5="Explica el redondeo en el README"
  notfound_bad="no se ha encontardo la factura %s"
  notfound_ok="no se ha encontrado la factura %s"
  readme="Los importes se redondean a céntimos con round()."
else
  m1="First version of the invoice service"
  m2="Add the tax service client"
  m3="Leave deleted invoices out of the listing (#398)"
  b3="They were still showing up in the customer portal."
  m4="Add tests for zero amounts"
  m5="Explain rounding in the README"
  notfound_bad="invoice %s not fonud"
  notfound_ok="invoice %s not found"
  readme="Amounts are rounded to cents with round()."
fi

write_queries() { # $1 = where clause, $2 = not-found message
cat > invoices/queries.py <<X
def list_invoices(db):
    return db.query("select * from invoices $1order by issued_at desc")


def get_invoice(db, number):
    rows = db.query("select * from invoices where number = %s", (number,))
    if not rows:
        raise LookupError("$2" % number)
    return rows[0]
X
}

write_tax() { # $1 = yes to include the unused function
cat > invoices/tax.py <<'X'
VAT_RATE = 0.21


def vat_for(amount):
    return round(amount * VAT_RATE, 2)


def total_with_vat(amount):
    return round(amount + vat_for(amount), 2)
X
if [ "$1" = yes ]; then
cat >> invoices/tax.py <<'X'


def total_with_vat_legacy(amount):
    return round(amount * 1.21, 2)
X
fi
}

write_client() { # $1 = timeout, $2 = retries
cat > invoices/tax_client.py <<X
import requests


class TaxClient:
    def __init__(self, base_url):
        self.base_url = base_url
        self.timeout = $1
        self.retries = $2

    def rate_for(self, country):
        for attempt in range(self.retries + 1):
            try:
                resp = requests.get(
                    "%s/rates/%s" % (self.base_url, country), timeout=self.timeout
                )
                resp.raise_for_status()
                return resp.json()["rate"]
            except requests.RequestException:
                if attempt == self.retries:
                    raise
X
}

c() { git add -A && git commit -q "$@"; }

mkdir -p invoices tests
: > invoices/__init__.py
write_tax yes
write_queries "" "$notfound_bad"
c -m "$m1"
write_client 5 0
c -m "$m2"
write_queries "where deleted_at is null " "$notfound_bad"
c -m "$m3" -m "$b3"
printf 'from invoices.tax import vat_for\n\n\ndef test_vat_zero():\n    assert vat_for(0) == 0\n' > tests/test_tax.py
c -m "$m4"
printf '# invoice-api\n\n%s\n' "$readme" > README.md
c -m "$m5"

case "$V" in
  timeout) write_client 30 2 ;;
  typo)    write_queries "where deleted_at is null " "$notfound_ok" ;;
  unused)  write_tax no ;;
esac
git add -A
