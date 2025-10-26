#!/bin/bash
set -e

# Neovim Multi-Config Setup
# Uses NVIM_APPNAME to manage multiple Neovim configurations
# Each config will be accessible via: NVIM_APPNAME=nvim-{name} nvim

DOT_FILES=~/dotfiles
NVIM_DOTFILES=$DOT_FILES/nvim

# Configuration array
# Format: "name:type:repo_url"
# Types:
#   - symlink: Direct symlink from ~/.config/nvim-{name} to ~/dotfiles/nvim/{name}
#   - clone: Clone a repo, then symlink custom config into it (like NvChad)
declare -a CONFIGS=(
  "custom:symlink" # Main configuration
  "legacy:symlink" # Config that uses my Vim configuration 
  
  # Pre-configured setups
  "nvchad:clone:https://github.com/NvChad/starter" # Neovim config providing solid defaults and a beautiful UI
  "astrovim:symlink" # Feature-rich Neovim configuration that focuses on extensibility and usability
  "kickstart:symlink" # starting point for Neovim that is: small, single file, documented
  "lazyvim:symlink" # Neovim setup powered by 💤 lazy.nvim to make it easy to customize and extend your config
  "lunarvim:symlink" # An IDE layer for Neovim with sane defaults. Completely free and community driven.
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

# Install NPM packages
install_npm_packages() {
  if command -v npm >/dev/null 2>&1; then
    printf "\n[dotfiles-nvim] Installing NPM packages\n"
    npm i -g vscode-langservers-extracted
  else
    printf "\n[dotfiles-nvim] Node.js not installed. Skipping NPM packages\n"
  fi
}

# Print usage instructions
print_usage() {
  printf "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
  printf "✓ Neovim configs installed successfully!\n\n"
  printf "Usage:\n"
  printf "  Add these aliases to your ~/.zshrc or ~/.bashrc:\n\n"

  for config_line in "${CONFIGS[@]}"; do
    IFS=':' read -r name type repo <<< "$config_line"
    printf "  alias nvim-$name='NVIM_APPNAME=nvim-$name nvim'\n"
  done

  printf "\n  Then use:\n"
  for config_line in "${CONFIGS[@]}"; do
    IFS=':' read -r name type repo <<< "$config_line"
    printf "  - nvim-$name    # Launch Neovim with $name config\n"
  done
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
  install_npm_packages
  print_usage
}

main
