#!/usr/bin/env bash
# Build the ChatGPT plugin upload from the repository root.
set -euo pipefail
cd "$(dirname "$0")/.."
out="${1:-$PWD/dist/deepmedchem-openai-plugin.zip}"
mkdir -p "$(dirname "$out")"
rm -f "$out"
zip -qrX "$out" plugin.json mcp.json skills assets -x '.*'
echo "$out"
