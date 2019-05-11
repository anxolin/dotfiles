
#!/bin/bash
set -e

# Create Vim backupo dir for swap, backup and undo files
echo "[dotfiles-vim] Creating Vim special dirs: Swap, Backup and Undo"
mkdir -p ~/.vim/backup_files
mkdir -p ~/.vim/swap_files
mkdir -p ~/.vim/undo_files

# Install Vundle (Vim plugin manager)
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  echo "[dotfiles-vim] Clone Vundle plugin into ~/.vim/bundle/Vundle.vim"
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  echo "[dotfiles-vim] Vundle plugin is already cloned into ~/.vim/bundle/Vundle.vim"
fi
