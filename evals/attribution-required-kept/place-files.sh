#!/usr/bin/env bash
set -eu
"$(dirname "$0")/../_fixtures/make-invoice-repo.sh" invoice-api commit
echo "- Commits written with an AI assistant must end with the trailer \`Assisted-by: <tool name>\`." >> invoice-api/AGENTS.md
