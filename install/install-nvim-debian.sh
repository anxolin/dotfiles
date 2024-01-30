# Install from sources

# Install required packages 
sudo apt-get -y install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen python3-venv

echo "[dotfiles-nvim-debian] Clone neovim"
git clone https://github.com/neovim/neovim.git /tmp/neovim
cd /tmp/neovim

echo "[dotfiles-nvim-debian] Build from sources (make)"
make CMAKE_BUILD_TYPE=RelWithDebInfo

echo "[dotfiles-nvim-debian] Build from sources (make install)"
sudo make install


