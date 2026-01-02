# dotfiles
This is my dotfile repo. There are many like it but this one is mine.

### Pre-commit

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
