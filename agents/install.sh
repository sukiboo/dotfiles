#!/usr/bin/env bash
# Install shared agent instructions and skills, then point Claude Code at them.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
agents_dir="$HOME/.agents"
claude_dir="$HOME/.claude"

mkdir -p "$agents_dir/skills" "$claude_dir/skills"

cp "$src/AGENTS.md" "$agents_dir/AGENTS.md"
cp -r "$src/skills/." "$agents_dir/skills/"

ln -sfn ../.agents/AGENTS.md "$claude_dir/CLAUDE.md"

for skill in "$agents_dir"/skills/*/; do
    name="$(basename "$skill")"
    ln -sfn "../../.agents/skills/$name" "$claude_dir/skills/$name"
    echo "linked $name"
done
