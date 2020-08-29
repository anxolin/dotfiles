
#!/bin/bash
set -e

# Create Vim backupo dir for swap, backup and undo files
echo "[dotfiles-vim] Creating Vim special dirs: Swap, Backup and Undo"
mkdir -p ~/.vim/backup_files
mkdir -p ~/.vim/swap_files
mkdir -p ~/.vim/undo_files
