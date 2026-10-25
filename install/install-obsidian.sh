#!/bin/bash
set -e

# Symlink shared Obsidian settings into every vault Obsidian knows about.
# Obsidian has no global config: each vault keeps its own .obsidian/ folder.
# Vaults are read from Obsidian's vault registry:
#   macOS: ~/Library/Application Support/obsidian/obsidian.json
#   Linux: ~/.config/obsidian/obsidian.json
# Re-run after creating a new vault. Obsidian must be restarted to pick up changes.

SRC_DIR=~/dotfiles/obsidian
FILES=(hotkeys.json)

if [[ $(uname) == 'Darwin' ]]; then
  REGISTRY="$HOME/Library/Application Support/obsidian/obsidian.json"
else
  REGISTRY="${XDG_CONFIG_HOME:-$HOME/.config}/obsidian/obsidian.json"
fi

if [ ! -f "$REGISTRY" ]; then
  printf "[dotfiles-obsidian] No vault registry at '%s' — skipping\n" "$REGISTRY"
  exit 0
fi

TIME_STAMP=$(date +%F_%R)
BACKUP_DIR=~/dotfiles/backup/obsidian_$TIME_STAMP

# obsidian.json is compact JSON: {"vaults":{"<id>":{"path":"/abs/path",...},...}}
grep -o '"path": *"[^"]*"' "$REGISTRY" | sed -E 's/"path": *"(.*)"/\1/' | while IFS= read -r VAULT; do
  if [ ! -d "$VAULT/.obsidian" ]; then
    printf "[dotfiles-obsidian] Vault '%s' not found — skipping\n" "$VAULT"
    continue
  fi

  for f in "${FILES[@]}"; do
    DST="$VAULT/.obsidian/$f"

    # Back up a real file before replacing it with the symlink
    if [ -f "$DST" ] && [ ! -L "$DST" ]; then
      mkdir -p "$BACKUP_DIR/$(basename "$VAULT")"
      cp "$DST" "$BACKUP_DIR/$(basename "$VAULT")/$f"
    fi

    ln -sfn "$SRC_DIR/$f" "$DST"
    printf "[dotfiles-obsidian] Linked %s -> %s\n" "$DST" "$SRC_DIR/$f"

    # If the vault is a git repo, hide the local symlink from git so it never
    # gets committed (the symlink would break for other clones):
    #   - tracked file: skip-worktree (undo: git update-index --no-skip-worktree .obsidian/<file>)
    #   - untracked file: add it to the repo's local .git/info/exclude
    if git -C "$VAULT" ls-files --error-unmatch ".obsidian/$f" >/dev/null 2>&1; then
      git -C "$VAULT" update-index --skip-worktree ".obsidian/$f"
      printf "[dotfiles-obsidian] Marked .obsidian/%s skip-worktree in %s\n" "$f" "$VAULT"
    elif git -C "$VAULT" rev-parse --git-dir >/dev/null 2>&1; then
      EXCLUDE="$(git -C "$VAULT" rev-parse --git-path info/exclude)"
      [[ $EXCLUDE = /* ]] || EXCLUDE="$VAULT/$EXCLUDE"
      mkdir -p "$(dirname "$EXCLUDE")"
      if ! grep -qxF "/.obsidian/$f" "$EXCLUDE" 2>/dev/null; then
        echo "/.obsidian/$f" >> "$EXCLUDE"
        printf "[dotfiles-obsidian] Excluded .obsidian/%s in %s\n" "$f" "$VAULT"
      fi
    fi
  done
done

printf "[dotfiles-obsidian] Obsidian settings installed\n"
