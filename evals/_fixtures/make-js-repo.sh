#!/usr/bin/env bash
# Builds a small JavaScript repo with unusual conventions: amounts in integer
# cents, errors returned as { error } instead of thrown, no semicolons,
# function declarations and node:test. Used by the code-style case.
# Usage: make-js-repo.sh <target-dir>
set -eu
T="$1"
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
mkdir -p "$T" && cd "$T"
git init -q -b main
git config user.name "Ana Ruiz"; git config user.email "ana@example.com"
mkdir -p src test
cat > package.json <<'X'
{
  "name": "invoice-api",
  "type": "module",
  "scripts": { "test": "node --test" }
}
X
cat > src/tax.js <<'X'
const VAT_PERCENT = 21

export function vatFor(cents) {
  if (!Number.isInteger(cents)) return { error: 'amount must be integer cents' }
  if (cents < 0) return { error: 'negative amount' }
  return { value: Math.round(cents * VAT_PERCENT / 100) }
}
X
cat > src/totals.js <<'X'
import { vatFor } from './tax.js'

export function totalWithVat(cents) {
  const vat = vatFor(cents)
  if (vat.error) return vat
  return { value: cents + vat.value }
}
X
cat > test/tax.test.js <<'X'
import { test } from 'node:test'
import assert from 'node:assert/strict'
import { vatFor } from '../src/tax.js'

test('vat on 100 euros', () => {
  assert.deepEqual(vatFor(10000), { value: 2100 })
})

test('rejects floats', () => {
  assert.equal(vatFor(10.5).error, 'amount must be integer cents')
})
X
printf '# invoice-api\n\nAll amounts are integer cents. Functions return { value } or { error }, they never throw.\n' > README.md
git add -A && git commit -q -m "first version"
