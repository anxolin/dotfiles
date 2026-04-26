# FZF dotfiles

FZF (fuzzy finder) is installed from source code in `bin-dependencies/fzf/` (git submodule).


## Basic Usage

### Command Line Usage

```bash
# Search files
fzf

# Search with specific directory
find . -type f | fzf

# Search git files only
git ls-files | fzf
```

### Key Bindings (when enabled)

- `Ctrl+T`: Search files and insert path
- `Ctrl+R`: Search command history
- `Alt+C`: Search directories and cd into selected

### Common Use Cases

```bash
# Search and open file with nvim
nvim $(fzf)

# Search directories and cd
cd $(find . -type d | fzf)

# Search processes and kill
kill $(ps aux | fzf | awk '{print $2}')

# Search git commits
git log --oneline | fzf

# Search environment variables
env | fzf
```

### Integration Examples

```bash
# With ripgrep (rg)
rg --files | fzf

# With fd
fd -t f | fzf

# With git
git ls-files | fzf --preview 'head -20 {}'
```

## Configuration

The fzf configuration is minimal and available in `fzf.zsh`.

## Installation

FZF is installed by `install/install-apps_Mac.sh` (brew) or `install/install-apps_Linux.sh` (apt/pacman/apk). The vim plugin (`junegunn/fzf.vim`) is installed by vim-plug.