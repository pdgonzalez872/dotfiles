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

function setup_dotfiles() {
  MSG="setting up dotfiles"
  echo "Start $MSG"
  git clone https://github.com/pdgonzalez872/dotfiles.git ~/dotfiles
  echo "Finish $MSG"
}

function setup_yarn() {
  MSG="setting up yarn"
  echo "Start $MSG"
  asdf plugin-add yarn
  asdf install yarn latest
  echo "Finish $MSG"
}

function setup_nvim_coc() {
  MSG="setting up nvim coc"
  echo "Start $MSG"
  cd ~/.vim/plugged/coc.nvim/
  yarn install
  cd ~
  echo "Finish $MSG"
}

function setup_elixir_ls() {
  MSG="setting up elixir-ls"
  echo "Start $MSG"
  mkdir -p ~/.vim/plugged/coc-elixir/els-release/
  curl -L https://github.com/elixir-lsp/elixir-ls/releases/download/v0.8.1/elixir-ls.zip > ~/.vim/plugged/coc-elixir/els-release/elixir-ls.zip
  unzip -o ~/.vim/plugged/coc-elixir/els-release/elixir-ls.zip -d ~/.vim/plugged/coc-elixir/els-release/
  echo "Finish $MSG"
}

function setup_vim() {
  MSG="setting up vim"
  echo "Start $MSG"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  sudo ln -sf ~/dotfiles/.vimrc ~/.vimrc
  # vim +PlugInstall +qall
  echo "Finish $MSG"
}

function setup_nvim() {
  MSG="setting up nvim"
  echo "Start $MSG"
  mkdir -p ~/.config/nvim
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  rm ~/.config/nvim/init.vim
  sudo ln -sf ~/.vimrc ~/.config/nvim/init.vim
  nvim +PlugInstall +qall
  echo "Finish $MSG"
}

function setup_git() {
  sudo ln -sf ~/dotfiles/.gitignore ~/.gitignore
  git config --global core.editor vim
}

function setup_gitignore() {
  git config --global core.excludesfile ~/.gitignore
}

function setup_tmux() {
  MSG="setting up tmux"
  echo "Start $MSG"
  sudo ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
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
  sudo ln -sf ~/dotfiles/.bashrc ~/.bashrc
  source ~/.bashrc
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
  TARGET_VERSION="24.2"
  export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"
  asdf install erlang $TARGET_VERSION
  asdf global erlang $TARGET_VERSION
  echo "Finish $MSG"
}

function install_elixir() {
  MSG="installing elixir"
  echo "Start $MSG"
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  TARGET_VERSION="1.13.1-otp-24"
  asdf install elixir $TARGET_VERSION
  asdf global elixir $TARGET_VERSION
  echo "Finish $MSG"
}

function install_postgres() {
  MSG="installing postgres"
  echo "Start $MSG"
  # From https://www.postgresql.org/download/linux/ubuntu/
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo apt-get update
  sudo apt-get -y install postgresql
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
  sudo docker pull postgres
  echo "Finish $MSG"
}

#
# Do Work
#

echo "Welcome to Paulo's machine setup script"

sudo apt update
simple_install "curl"
simple_install "git"
setup_git
setup_gitignore
setup_dotfiles
simple_install "vim"
setup_vim
# simple_install "neovim"
# setup_nvim
# setup_nvim_coc
simple_install "tmux"
setup_tmux
simple_install "gnome-tweaks"
simple_install "silversearcher-ag"
simple_install "nginx"
simple_install "fail2ban"
setup_asdf
setup_yarn
setup_bashrc
setup_elixir_ls
install_erlang
install_elixir
install_postgres
simple_install "npm"
simple_install "nodejs"

## Uncomment these if you'd like.
install_docker
install_docker_compose
# pull_postgres_docker
