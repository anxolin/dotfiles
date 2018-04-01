#!/bin/bash
set -e

# Compiles vim from the sources
git clone https://github.com/vim/vim.git /tmp/vim-build \
  && cd /tmp/vim-build \
  && ./configure --enable-pythoninterp --prefix=/usr --with-python-config-dir=/usr/lib/python2.7/config --enable-python3interp \
  && make \
  && make install \
  && rm -rf /tmp/vim-build
