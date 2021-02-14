#!/bin/bash

#
# Use this when setting up a new Ubuntu 20.04 dev machine
#

#
# Functions
#

function simple_install() {
  echo "Start installing $1"
  sudo apt install $1 -y
  echo "Finish installing $1"
}

function setup_vim() {
  MSG="setting up vim"
  echo "Start $MSG"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ln -sf ~/dotfiles/.vimrc ~/.vimrc
  echo "Finish $MSG"
}

function setup_tmux() {
  MSG="setting up tmux"
  echo "Start $MSG"
  ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  tmux source ~/.tmux.conf
  echo "Finish $MSG"
}

function setup_asdf() {
  MSG="setting up asdf"
  echo "Start $MSG"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  echo "Finish $MSG"
}

function setup_bashrc() {
  MSG="setting up bashrc"
  echo "Start $MSG"
  ln -sf ~/dotfiles/.bashrc ~/.bashrc
  source ~./bashrc
  echo "Finish $MSG"
}

function install_erlang() {
  MSG="installing erlang"
  echo "Start $MSG"
  asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  sudo apt-get -y install build-essential autoconf m4 libncurses5-dev \
    libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev \
      libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev \
        openjdk-11-jdk
  TARGET_VERSION="23.2.4"
  export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"
  asdf install erlang $TARGET_VERSION
  asdf global erlang $TARGET_VERSION
  echo "Finish $MSG"
}

function install_elixir() {
  MSG="installing elixir"
  echo "Start $MSG"
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  TARGET_VERSION="master-otp-23"
  asdf install elixir $TARGET_VERSION
  asdf global elixir $TARGET_VERSION
  echo "Finish $MSG"
}

function install_docker() {
  MSG="installing docker"
  echo "Start $MSG"
  sudo apt-get remove docker docker-engine docker.io containerd runc
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  echo "Finish $MSG"
}

function install_docker_compose() {
  MSG="installing docker compose"
  echo "Start $MSG"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  echo "Finish $MSG"
}

function pull_postgres_docker() {
  MSG="pull postgres docker"
  echo "Start $MSG"
  docker pull postgres
  echo "Finish $MSG"
}


#
# Do Work
#

echo "Welcome to Paulo's machine setup script"

simple_install "curl"
simple_install "git"
simple_install "vim"
simple_install "tmux"
git clone https://github.com/pdgonzalez872/dotfiles.git ~/dotfiles
setup_vim
setup_tmux
setup_asdf
setup_bashrc
install_erlang
install_elixir
simple_install "npm"
simple_install "nodejs"
install_docker
install_docker_compose
pull_postgres_docker

echo "** Run :PluginInstall inside vim to get all the vim deps"

echo "Everything should be good to go now"
