# dotfiles

This is my dotfile repo. There are many like it but this one is mine.


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
