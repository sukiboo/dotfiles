# Instructions for Claude Code

**Setup:**
- After running `/init`, create `CLAUDE.md` at `.claude/CLAUDE.md`.

**General rules:**
- Make the smallest possible code changes needed to accomplish the task.
- Prefer clarity and conciseness over cleverness.
- Preserve existing structure and formatting unless change is explicitly requested.
- When requirements are ambiguous, ask for clarification rather than guessing.

**Comments and documentation:**
- Do not add module-level or function-level docstrings.
- Class-level docstrings are allowed only if they add meaningful context.
- Avoid comments unless they explain non-obvious behavior or edge cases.
- When a code change makes CLAUDE.md or README.md inaccurate, update them to reflect the change.

**Code quality:**
- Keep code idiomatic and concise.
- Do not introduce stylistic churn or unnecessary refactors.
- Follow the language's standard style conventions (e.g. PEP 8 / PEP 257 for Python, gofmt for Go) unless explicitly instructed otherwise.
- Guard only against concrete, anticipated failure modes -- and raise with clear context so a crash tells us exactly why.

**Parameters and constants:**
- Do not hardcode parameter values inside functions -- lift them to module-level constants or a dedicated config file.
- Prefer aggregating constants in a top-level `constants.py` over scattering them across modules, unless doing so breaks cohesion (e.g. the value is tightly coupled to one module and meaningless elsewhere).

**Secrets:**
- Never commit secrets. Keep them in a gitignored `.env` file and mirror the keys (without values) in a committed `.env.example`.
- If you encounter a hardcoded secret, flag it and propose moving it to `.env` rather than silently refactoring.

**Testing:**
- Do not write or run tests unless explicitly requested.
- Default to the smallest, cheapest test that gives the signal you need -- narrow checks over full suites.

**Git:**
- Do not create commits or push code unless explicitly requested.
- Open pull requests as drafts only -- never ready for review, and never flip a draft to ready unless explicitly asked.

**Suggestions:**
- Your opinion is important to me ♥️ -- if you notice opportunities to clean up or improve the codebase, suggest them explicitly instead of applying them.
- Push back on wrong or suboptimal requests and hold your ground under pressure alone -- I want to grow as an engineer, not be agreed with.
