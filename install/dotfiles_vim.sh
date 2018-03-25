
#!/bin/bash
set -e

# Create Vim backupo dir for swap, backup and undo files
mkdir -p ~/.vim/{backup_files,swap_files,undo_files}

# Install Vundle (Vim plugin manager)
git clone https://github.com/VundleVim/Vundle.vim.git vim/bundle/Vundle.vim
