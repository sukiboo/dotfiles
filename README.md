# dotfiles

This is my dotfile repo. There are many like it but this one is mine.


## Cursor

My Cursor configuration. It's where the work happens nowadays because AI.

#### Setup

To use this Cursor configuration:

1. Install Cursor (if not already installed):
   - Download from [cursor.sh](https://cursor.sh)

2. Copy files from `cursor/User/` to `~/.config/Cursor/User/`:
   ```bash
   cp -r cursor/User/* ~/.config/Cursor/User/
   ```

#### What's included

The configuration includes:
- **Editor settings**: Minimalist setup with AI suggestions disabled, word wrap, and custom terminal profiles
- **Keybindings**: Custom keyboard shortcuts (e.g., F5 for Python execution)
- **Python configuration**: Type checking and analysis settings
- **Terminal integration**: Custom tmux-based terminal profile
- **UI preferences**: Disabled minimap, custom tree indentation, and workspace trust settings


## Claude Code

Claude is love, Claude is life.

#### Setup

Copy `claude/CLAUDE.md` to `~/.claude/CLAUDE.md`:
```bash
mkdir -p ~/.claude && cp claude/CLAUDE.md ~/.claude/CLAUDE.md
```

#### What's included

The global Claude config defining my coding preferences.


## Terminal

My GNOME Terminal color scheme. A dark theme with a custom color palette.

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

The configuration includes:
- **Color palette**: Custom 16-color scheme with dark background
- **Profile settings**: Bold-is-bright enabled, custom column width
- **Theme**: Dark theme variant


## Geany

My Geany configuration. It's a nice lightweight IDE that was my go-to prior to Cursor, and I still choose it for non-AI workflows.

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

The configuration includes:
- **Colorschemes**: Custom dark themes
- **Keybindings**: Custom keyboard shortcuts
- **Filetype definitions**: Python syntax highlighting and build commands
- **Editor settings**: Preferences for indentation, fonts, and UI layout


## Pre-commit

Pre-commit configuration (`.pre-commit-config.yaml`) that I use in my Python projects.

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

The configuration includes:
- **File validation**: JSON, YAML, TOML, XML syntax checks
- **Code quality**: Trailing whitespace, end-of-file newlines, merge conflicts
- **Security**: Private key detection, Python security issues (bandit)
- **Python tools**: Type checking (mypy), import sorting (isort), linting (flake8), formatting (black)
- **Jupyter notebooks**: Same Python tools applied to `.ipynb` files via nbQA


## Texmaker

My Texmaker configuration. An open source LaTeX editor with syntax highlighting and integrated PDF viewer.

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

The configuration includes:
- **Editor settings**: Font preferences, syntax highlighting colors, tab settings
- **Build commands**: LaTeX, PDFLaTeX, BibTeX, and other compilation tools
- **Spell checker**: Custom dictionary with technical terms
- **UI preferences**: Window geometry, toolbar visibility, and view settings

