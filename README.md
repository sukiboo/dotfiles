# dotfiles

This is my dotfiles repo. There are many like it, but this one is mine.


## Claude Code

Claude is love, Claude is life.

#### Setup

Copy files from `claude/` to `~/.claude/`:
```bash
mkdir -p ~/.claude && cp claude/CLAUDE.md claude/settings.json claude/statusline-command.sh ~/.claude/
```

#### What's included

- **CLAUDE.md**: Global instructions defining my coding preferences.
- **settings.json**: Permission rules for allowed and denied shell commands.
- **statusline-command.sh**: Custom status line showing model, context usage, token counts, and cost.


## VS Code

VSCode is my IDE of choice nowadays (*again!*), mainly because of seamless Claude Code integration.
When every "Agentic IDE" is a "VSCode fork", why not use the original?

#### Setup

1. Copy files from `code/User/` to `~/.config/Code/User/`:
   ```bash
   cp -r code/User/* ~/.config/Code/User/
   ```

#### What's included

Editor settings, Python/Lua/Jupyter config, Claude Code integration, and UI preferences.


## Cursor

Cursor is where the work happens nowadays because AI (*well, maybe not anymore...*).
My preferred configuration -- minimal UI, no AI suggestions, format on save.

#### Setup

To use this Cursor configuration:

1. Install Cursor (if not already installed):
   - Download from [cursor.sh](https://cursor.sh)

2. Copy files from `cursor/User/` to `~/.config/Cursor/User/`:
   ```bash
   cp -r cursor/User/* ~/.config/Cursor/User/
   ```

#### What's included

Editor settings, keybindings (F5 for Python), Python config, and UI preferences.


## Terminal

My GNOME Terminal color scheme.
Nothing fancy, just a dark theme with a custom color palette that I find a bit more pleasant to look at -- and I do have to look at terminals a lot.

#### Setup

To use this terminal color configuration:

1. Navigate to the `terminal/` directory:
   ```bash
   cd terminal/
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

   The script will automatically generate a new profile UUID and set it as default.

3. Restart your terminal for changes to take effect.

#### What's included

Custom 16-color dark palette, bold-is-bright, and profile settings.


## Geany

My Geany configuration. It's a nice lightweight IDE that was my go-to prior to Cursor, and I still choose it for non-AI workflows (*even though those are becoming excessively rare*).

#### Setup

To use this Geany configuration:

1. Install Geany, the Auto-mark plugin, and built-in terminal support:
   ```bash
   sudo apt install geany geany-plugin-automark libvte9
   ```

2. Copy files from `geany/` to `~/.config/geany/`:
   ```bash
   cp -r geany/* ~/.config/geany/
   ```

3. Enable the Auto-mark plugin:
   - Tools → Plugin Manager → Enable Auto-mark

4. Change colorscheme (optional):
   - View → Change Color Scheme... → Select desired scheme

5. Configure build commands (optional):
   - Build → Set Build Commands
   - Execute commands:
     - Run: `python3 %f`
     - Run in Python: `python3 -i %f`

#### What's included

Colorschemes, keybindings, filetype definitions, and editor settings.


## Pre-commit

Pre-commit configuration (`.pre-commit-config.yaml`) that I use in my Python projects so that my code doesn't look like shit.

#### Setup

To use this pre-commit configuration in a repository:

1. Copy the `.pre-commit-config.yaml` file from `precommit/` to the project root
2. Install pre-commit (if not already installed):
   ```bash
   pip install pre-commit
   ```
3. Install the git hooks:
   ```bash
   pre-commit install
   ```

#### Usage

- Pre-commit hooks will automatically run on `git commit`
- To run hooks manually on all files:
  ```bash
  pre-commit run --all-files
  ```
- To update hooks to latest versions:
  ```bash
  pre-commit autoupdate
  ```

#### What it checks

File validation, code quality, security (bandit), Python tools (mypy, isort, flake8, black), and Jupyter support via nbQA.


## Texmaker

My Texmaker configuration. An open source LaTeX editor with syntax highlighting and integrated PDF viewer from the good old PhD days.

#### Setup

To use this Texmaker configuration:

1. Install Texmaker:
   ```bash
   sudo apt install texmaker
   ```

2. Copy files from `texmaker/` to `~/.config/xm1/`:
   ```bash
   cp -r texmaker/xm1/* ~/.config/xm1/
   cp texmaker/settings.ini ~/.config/xm1/
   ```

#### What's included

Editor settings, build commands, spell checker dictionary, and UI preferences.

