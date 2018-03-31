# docker run -u anxo -it 820613b91511 sh
FROM alpine:latest

MAINTAINER Angel Rodriguez "anxolin@gmail.com"


# Install some basic apps
#   - Since we are compiling vim with python3 support, we need some dependencies first
#   - Intsall other basic apps like git, zsh, tmux
#   - Then install some apps that vim plugins depend on: xclip, ctags, ag, ...
RUN \
  apk add --no-cache \
    gcc make ncurses-dev ncurses python-dev python3-dev python python3 ctags nodejs-npm musl-dev su-exec \
    git \
    zsh \
    tmux \
    vim \
    the_silver_searcher \
    xclip \
    ctags \
    cmake \
  && cd /tmp && git clone https://github.com/vim/vim.git && cd vim \
  && ./configure --enable-pythoninterp --prefix=/usr --with-python-config-dir=/usr/lib/python2.7/config --enable-python3interp \
  && make && make install \
  && addgroup anxo \
  && adduser -Ds /bin/zsh anxo -G anxo

USER anxo

RUN \
  git clone https://github.com/anxolin/dotfiles.git /home/anxo/dotfiles && \
  chmod +x /home/anxo/dotfiles/install.sh && \
  sh -x /home/anxo/dotfiles/install.sh 
  
