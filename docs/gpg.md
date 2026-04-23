# GPG

GnuPG: public-key crypto used by `pass` (password manager), git commit signing, email, package verification, etc.

## Install

Handled by the platform install scripts:

- macOS (`install/install-apps_Mac.sh`) → `gnupg` + `pinentry-mac`
- Debian/Ubuntu → `gnupg pinentry-curses`
- Arch / Alpine → `gnupg pinentry`

## Pinentry

`pinentry` is the helper `gpg-agent` spawns to ask for your passphrase. Pick the variant that matches where you're running:

- **`pinentry-mac`** — native macOS dialog, can cache passphrase in Keychain. Default on this Mac.
- **`pinentry-curses`** — ncurses prompt inside the terminal. Works over SSH and in headless contexts.
- **`pinentry-tty`** — bare tty prompt. Fallback.
- **`pinentry-gnome3` / `-qt`** — GUI dialogs on Linux desktops.

Wire it via `~/.gnupg/gpg-agent.conf`:

```conf
default-cache-ttl 600
max-cache-ttl 7200
pinentry-program /opt/homebrew/bin/pinentry-mac
```

After editing, reload the agent: `gpgconf --kill gpg-agent` (respawns on next use).

`GPG_TTY` is exported by `zsh/common.zsh` and `bash/bashrc` so curses/tty pinentries can find the terminal. Harmless when `pinentry-mac` is in use.

## Keys — day-to-day commands

```bash
# Generate a new key (ECC / Curve 25519 recommended: fast, small, modern)
gpg --full-generate-key

# List secret keys (for `pass init`, git signing, etc.)
gpg --list-secret-keys --keyid-format=long

# Export a public key (share this freely)
gpg --export --armor <KEY_ID_OR_EMAIL> > anxo-public.asc

# Export a secret key (never share — transfer over a trusted channel only)
gpg --export-secret-keys --armor <KEY_ID_OR_EMAIL> > anxo-private.asc

# Import a key
gpg --import anxo-private.asc

# After importing your own key on a new machine, trust it ultimately:
gpg --edit-key <KEY_ID>    # then: trust → 5 → y → quit
```

## Further reading

- [GnuPG docs](https://www.gnupg.org/documentation/)
- [`pass` — password manager built on GPG](https://www.passwordstore.org/)
- [Git commit signing](https://docs.github.com/en/authentication/managing-commit-signature-verification)
