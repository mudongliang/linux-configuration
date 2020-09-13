#!/bin/bash

# export LINUX_CONFIG_REPO this time
export LINUX_CONFIG_REPO=$HOME/.config/linux_config_repo

prompt() {
  read -p 'Will you run '$1'?[y/N]' PMT
  if [[ $PMT == 'y' || $PMT == 'Y' ]]; then
    . ./$1
  fi
}

build_dependency(){
  sudo apt -y install git trash-cli lsb-release curl
}

check_distribution(){
  OS=$(cat /etc/issue | head -n 1 | cut -f 1 -d ' ')
  case $OS in
  'Ubuntu'|'Debian')
    sudo apt -y update; sudo apt -y upgrade;
    ;;
  *)
    echo "Your distribution - $OS is not supported"
    exit
    ;;
esac
}

install_bashrc(){
  cat bashrc/bashrc >> ~/.bashrc
  echo "Do source ~/.bashrc to activate the bashrc"
}

install_extensions(){
  ./bin/gnome-shell-extension-restore
}

get_software(){
  pushd $LINUX_CONFIG_REPO/installation.d/get.d
  SW_LIST=(get-tmux
           get-docker)

  for SW in ${SW_LIST[@]}; do
    prompt $SW
  done
  popd
}

config_software(){
  pushd $LINUX_CONFIG_REPO/installation.d/conf.d
  CONF_LIST=(config-git)

  for CONF in ${CONF_LIST[@]}; do
    prompt $CONF
  done
  popd
}

build_dependency

check_distribution

install_bashrc

install_extensions

get_software

config_software
