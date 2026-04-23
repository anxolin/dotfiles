# pass — Unix password manager

[`pass`](https://www.passwordstore.org/) stores each entry as a GPG-encrypted file under `~/.password-store/`. One file per password, directories for organization, optional git sync.

See [`docs/gpg.md`](gpg.md) for GPG setup (required — `pass` is a thin wrapper on `gpg` + `git`).

## Storage layout

```
~/.password-store/
├── .gpg-id               # Fingerprint of the key that can decrypt the store
├── .git/                 # Git repository
├── email/
│   └── gmail.gpg         # one encrypted file per entry
└── wifi/
    └── home.gpg
```

Decrypted file contents: first line is the password; following lines are free-form metadata (username, URL, recovery codes, …). `pass -c` copies only line 1.

## Install

Handled by the platform install scripts:

- macOS → `pass gnupg pinentry-mac`
- Debian/Ubuntu → `pass gnupg pinentry-curses`
- Arch / Alpine → `pass gnupg pinentry`

## Initialize the store

```bash
# Pick the GPG key that can decrypt this store (key ID, fingerprint, or email)
pass init <KEY_ID>

# Optional: turn it into a git repo (auto-commits on every insert/edit/rm/mv)
pass git init
```

## Daily commands

```bash
# Add / generate
pass insert email/gmail          # prompt for password (hidden)
pass insert -m email/gmail       # multiline (paste full body, Ctrl-D to end)
pass generate wifi/home 20       # generate a 20-char password
pass generate -n wifi/home 20    # no symbols, alphanumeric only

# Show / copy
pass email/gmail                 # print full file to terminal
pass -c email/gmail              # copy password to clipboard (auto-clear 45s)
pass -q email/gmail              # display as QR code

# List / search
pass                             # tree of all entries
pass email                       # subtree
pass find gmail                  # search entry names
pass grep "example.com"          # search entry contents (decrypts each)

# Modify
pass edit email/gmail            # open in $EDITOR, re-encrypts on save
pass mv email/gmail email/personal/gmail
pass rm email/gmail
```

## Git sync

The store is a normal git repo, so all `git` commands work via the `pass git` wrapper:

```bash
pass git log --oneline
pass git remote add origin git@github.com:<you>/password-store.git
pass git push -u origin main
pass git pull
```

Files are GPG-encrypted, so pushing to a private remote is safe.

## Another machine

1. Import your secret key on the new machine (see [`gpg.md`](gpg.md) — export / import / trust).
2. Clone the store:
   ```bash
   git clone git@github.com:<you>/password-store.git ~/.password-store
   ```
3. Use it.

## Multiple keys for one store

Re-run `pass init` with multiple key IDs to allow any of them to decrypt. Useful on a YubiKey / shared family store:

```bash
pass init <KEY_A> <KEY_B>
```

All existing entries get re-encrypted to the new recipient set.

## Further reading

- [Official site](https://www.passwordstore.org/)
- [Man page](https://git.zx2c4.com/password-store/about/)
- GUI / mobile clients: Passforios (iOS), Password Store (Android), QtPass (desktop), pass-winmenu (Windows).
