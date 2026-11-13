#!/usr/bin/env bash
set -eu
"$(dirname "$0")/../_fixtures/make-invoice-repo.sh" invoice-api commit
cat > invoice-api/CONTRIBUTING.md <<'X'
# Contributing

We don't accept contributions written with AI tools (code, commits or PR descriptions). Pull requests that use them will be closed and the author may be blocked.
X
