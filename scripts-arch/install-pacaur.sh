#!/usr/bin/env bash

# Install Pacaur
cd /tmp || exit 1
buildroot="$(mktemp -d)"

sudo -v
echo "Clean everythin up"
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53

mkdir -p "$buildroot"
cd "$buildroot" || exit 1

echo "Get cower - a simple AUR downloader"
git clone "https://aur.archlinux.org/cower.git"

echo "Get pacaur - An AUR helper that minimizes user interaction"
git clone "https://aur.archlinux.org/pacaur.git"

echo "Generate and install cower package (and dependencies)"
cd "${buildroot}/cower" || exit 1
makepkg --syncdeps --install --noconfirm

echo "Generate and install pacaur package (and dependencies)"
cd "${buildroot}/pacaur" || exit 1
makepkg --syncdeps --install --noconfirm

echo "Clean everythin up"
cd /tmp || exit 1
rm -rf "$buildroot"
