#!/bin/bash
set -e

# Neovim Multi-Config Setup
# Uses NVIM_APPNAME to manage multiple Neovim configurations
# Each config will be accessible via: NVIM_APPNAME=nvim-{name} nvim
#
# Dependencies:
#   Required:
#     - git
#     - neovim
#
#   Optional (auto-installed if available):
#     - Node.js/npm:
#         - neovim (Neovim Node.js provider - enables Node-based plugins)
#         - vscode-langservers-extracted (HTML/CSS/JSON/ESLint LSP servers)
#     - Python3/pip:
#         - pynvim (Neovim Python provider - enables Python-based plugins)
#
#   Note: Perl and Ruby providers are disabled in Neovim configs as they're
#   rarely needed for modern plugins.
#
#   If Node.js or Python are not installed, warnings will be shown but
#   Neovim will still work. Install them later if you need those features.

DOT_FILES=~/dotfiles
NVIM_DOTFILES=$DOT_FILES/nvim

# Configuration array
# Format: "name:type:repo_url"
# Types:
#   - symlink: Direct symlink from ~/.config/nvim-{name} to ~/dotfiles/nvim/{name}
#   - clone: Clone a repo, then symlink custom config into it (like NvChad)
declare -a CONFIGS=(
  "custom:symlink" # Main configuration
  "custom2:symlink" # Alternative configuration
  "legacy:symlink" # Config that uses my Vim configuration
  "empty:symlink"  # Empty nvim config (defaults)

  # Pre-configured setups
  "nvchad:clone:https://github.com/NvChad/starter" # Neovim config providing solid defaults and a beautiful UI
  "astrovim:symlink" # Feature-rich Neovim configuration that focuses on extensibility and usability
  "kickstart:symlink" # starting point for Neovim that is: small, single file, documented
  "lazyvim:symlink" # Neovim setup powered by 💤 lazy.nvim to make it easy to customize and extend your config
  "lunarvim:symlink" # An IDE layer for Neovim with sane defaults. Completely free and community driven.
)

# Node.js packages to install (requires npm)
declare -a NPM_PACKAGES=(
  "neovim"                        # Neovim Node.js provider (its optional, but nice to have. Shows up as warning in :checkhealth otherwise)
  "vscode-langservers-extracted"  # HTML/CSS/JSON/ESLint language servers (used for vim not neovim I believe)
  "vscode-solidity-server", # Dependencies of https://github.com/neovim/nvim-lspconfig/blob/master/lsp/solidity_ls.lua
)

# Python packages to install (requires pip/pip3)
declare -a PYTHON_PACKAGES=(
  "pynvim"  # Neovim Python provider. (its optional, but nice to have. Shows up as warning in :checkhealth otherwise)
)

# Backup existing configs
backup_configs() {
  local TIME_STAMP=$(date +%F_%R)
  local BACKUP_DIR=$DOT_FILES/backup/nvim_$TIME_STAMP

  printf "[dotfiles-nvim] Backing up existing configs to '$BACKUP_DIR'\n"
  mkdir -p "$BACKUP_DIR"

  for config_line in "${CONFIGS[@]}"; do
    IFS=':' read -r name type repo <<< "$config_line"
    local config_dir=~/.config/nvim-$name

    if [ -d "$config_dir" ] || [ -L "$config_dir" ]; then
      printf "  - Backing up nvim-$name\n"
      cp -rf "$config_dir" "$BACKUP_DIR/nvim-$name" 2>/dev/null || :
    fi
  done

  # Backup old default nvim config if it exists
  if [ -d ~/.config/nvim ] || [ -L ~/.config/nvim ]; then
    printf "  - Backing up default nvim config\n"
    cp -rf ~/.config/nvim "$BACKUP_DIR/nvim-default" 2>/dev/null || :
  fi
}

# Clean old configs
clean_configs() {
  printf "[dotfiles-nvim] Cleaning old configs\n"

  for config_line in "${CONFIGS[@]}"; do
    IFS=':' read -r name type repo <<< "$config_line"
    local config_dir=~/.config/nvim-$name

    if [ -d "$config_dir" ] || [ -L "$config_dir" ]; then
      printf "  - Removing nvim-$name\n"
      rm -rf "$config_dir"
    fi

    # Clean plugin data for this config
    rm -rf ~/.local/share/nvim-$name 2>/dev/null || :
    rm -rf ~/.local/state/nvim-$name 2>/dev/null || :
  done
}

# Setup a single config
setup_config() {
  local name=$1
  local type=$2
  local repo=$3
  local config_dir=~/.config/nvim-$name
  local source_dir=$NVIM_DOTFILES/$name

  printf "\n[dotfiles-nvim] Setting up nvim-$name (type: $type)\n"

  # Check if source directory exists
  if [ ! -d "$source_dir" ]; then
    printf "  ⚠️  Warning: Source directory not found: $source_dir (skipping)\n"
    return
  fi

  case $type in
    symlink)
      printf "  - Creating symlink: $config_dir -> $source_dir\n"
      ln -sf "$source_dir" "$config_dir"
      ;;

    clone)
      if [ -z "$repo" ]; then
        printf "  ⚠️  Error: Clone type requires repo URL (skipping)\n"
        return
      fi

      printf "  - Cloning $repo to $config_dir\n"
      git clone "$repo" "$config_dir" --depth 1

      printf "  - Creating custom config symlink: $config_dir/lua/custom -> $source_dir\n"
      ln -sf "$source_dir" "$config_dir/lua/custom"
      ;;

    *)
      printf "  ⚠️  Error: Unknown type '$type' (skipping)\n"
      return
      ;;
  esac

  printf "  ✓ nvim-$name setup complete\n"
}

# Setup all configs
setup_all_configs() {
  mkdir -p ~/.config

  for config_line in "${CONFIGS[@]}"; do
    IFS=':' read -r name type repo <<< "$config_line"
    setup_config "$name" "$type" "$repo"
  done
}

# Install Neovim dependencies (Node.js and Python packages)
install_neovim_dependencies() {
  printf "\n[dotfiles-nvim] Installing Neovim dependencies\n"

  # Install Node.js packages
  if command -v npm >/dev/null 2>&1; then
    printf "\n  📦 Installing Node.js packages:\n"
    for package in "${NPM_PACKAGES[@]}"; do
      printf "    - Installing: $package\n"
      npm install -g "$package" >/dev/null 2>&1 && printf "      ✓ Installed\n" || printf "      ⚠️  Failed\n"
    done
  else
    printf "\n  ⚠️  WARNING: Node.js not installed\n"
    printf "     Install Node.js to enable:\n"
    printf "     - Node.js-based plugins\n"
    printf "     - Some LSP servers (html, css, json, eslint)\n"
    printf "     Packages to install manually: ${NPM_PACKAGES[*]}\n"
  fi

  # Install Python packages
  if command -v pip3 >/dev/null 2>&1; then
    printf "\n  🐍 Installing Python packages:\n"
    for package in "${PYTHON_PACKAGES[@]}"; do
      printf "    - Installing: $package\n"
      pip3 install --quiet "$package" && printf "      ✓ Installed\n" || printf "      ⚠️  Failed\n"
    done
  elif command -v pip >/dev/null 2>&1; then
    printf "\n  🐍 Installing Python packages (using pip):\n"
    for package in "${PYTHON_PACKAGES[@]}"; do
      printf "    - Installing: $package\n"
      pip install --quiet "$package" && printf "      ✓ Installed\n" || printf "      ⚠️  Failed\n"
    done
  else
    printf "\n  ⚠️  WARNING: Python/pip not installed\n"
    printf "     Install Python3 and pip to enable:\n"
    printf "     - Python-based plugins\n"
    printf "     - Some formatters and linters\n"
    printf "     Packages to install manually: ${PYTHON_PACKAGES[*]}\n"
  fi
}

# Create zsh aliases file
create_zsh_aliases() {
  local ZSH_NVIM_FILE=~/.zsh/nvim.zsh

  printf "\n[dotfiles-nvim] Creating zsh aliases file: $ZSH_NVIM_FILE\n"

  # Create .zsh directory if it doesn't exist
  mkdir -p ~/.zsh

  # Create the aliases file
  cat > "$ZSH_NVIM_FILE" << 'EOF'
# Neovim Multi-Config Setup
# Generated by ~/dotfiles/install/dotfiles_nvim.sh

# Set default config to custom
export NVIM_APPNAME=nvim-custom

# Aliases for switching between configs
EOF

  for config_line in "${CONFIGS[@]}"; do
    IFS=':' read -r name type repo <<< "$config_line"
    # Extract comment if present
    local comment=""
    if [[ "$config_line" == *"#"* ]]; then
      comment=" # ${config_line##*#}"
    fi
    echo "alias nvim-$name='NVIM_APPNAME=nvim-$name nvim'$comment" >> "$ZSH_NVIM_FILE"
  done

  printf "  ✓ Aliases file created\n"
}

# Print usage instructions
print_usage() {
  printf "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf "✓ Neovim configs installed successfully!\n\n"

  printf "Next steps:\n\n"

  printf "1. Source the zsh config in your ~/.zshrc:\n"
  printf "   echo 'source ~/.zsh/nvim.zsh' >> ~/.zshrc\n"
  printf "   source ~/.zshrc\n\n"

  printf "2. Launch Neovim with any config:\n"
  printf "   - nvim           # Default (custom config)\n"
  for config_line in "${CONFIGS[@]}"; do
    IFS=':' read -r name type repo <<< "$config_line"
    printf "   - nvim-$name\n"
  done

  printf "\n3. First launch will:\n"
  printf "   - Auto-install plugins (via lazy.nvim)\n"
  printf "   - Install LSP servers (via Mason)\n"
  printf "   - This takes 2-3 minutes\n\n"

  printf "4. Verify installation:\n"
  printf "   Run :checkhealth in Neovim\n\n"

  printf "📦 Dependencies installed:\n"
  if command -v npm >/dev/null 2>&1; then
    printf "   ✓ Node.js packages (neovim, vscode-langservers-extracted)\n"
  else
    printf "   ⚠️  Node.js not found - install to enable Node-based plugins\n"
  fi

  if command -v pip3 >/dev/null 2>&1 || command -v pip >/dev/null 2>&1; then
    printf "   ✓ Python packages (pynvim)\n"
  else
    printf "   ⚠️  Python not found - install to enable Python-based plugins\n"
  fi

  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
}

# Main execution
main() {
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf "Neovim Multi-Config Setup\n"
  printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

  backup_configs
  clean_configs
  setup_all_configs
  install_neovim_dependencies
  create_zsh_aliases
  print_usage
}

main
