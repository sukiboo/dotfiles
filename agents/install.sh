#!/usr/bin/env bash
# Install shared agent instructions and skills, then point agent harnesses at them.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
agents_dir="$HOME/.agents"
claude_dir="$HOME/.claude"
pi_dir="${PI_CODING_AGENT_DIR:-$HOME/.pi/agent}"

mkdir -p "$agents_dir/skills" "$claude_dir/skills" "$pi_dir"

cp "$src/AGENTS.md" "$agents_dir/AGENTS.md"
cp -r "$src/skills/." "$agents_dir/skills/"

ln -sfn ../.agents/AGENTS.md "$claude_dir/CLAUDE.md"
ln -sfn "$agents_dir/AGENTS.md" "$pi_dir/AGENTS.md"

for skill in "$agents_dir"/skills/*/; do
    name="$(basename "$skill")"
    ln -sfn "../../.agents/skills/$name" "$claude_dir/skills/$name"
    echo "linked $name"
done
