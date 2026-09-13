#!/usr/bin/env bash
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
pi_dir="${PI_CODING_AGENT_DIR:-$HOME/.pi/agent}"

mkdir -p "$pi_dir/extensions" "$pi_dir/themes"

cp "$src/settings.json" "$pi_dir/"
cp "$src/extensions/statusline.ts" "$pi_dir/extensions/"
cp "$src/themes/sukiboo.json" "$pi_dir/themes/"

rm -f "$pi_dir/extensions/suki-footer.ts"

echo "Pi settings installed to $pi_dir"
