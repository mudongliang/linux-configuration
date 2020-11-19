#!/bin/bash

# export LINUX_CONFIG_REPO this time
export LINUX_CONFIG_REPO=$HOME/.config/linux_config_repo

prompt() {
  read -p 'Will you run '$1'?[y/N]' PMT
  if [[ $PMT == 'y' || $PMT == 'Y' ]]; then
    . $1
  fi
}

build_dependency(){
  sudo apt -y install git curl wget gdebi trash-cli 
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

remove_gnomegames(){
  sudo apt purge -y aisleriot four-in-a-row gnome-mahjongg gnome-mines gnome-sudoku gbrainy gnome-robots gnome-chess lightsoff quadrapassel
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
  SW_LIST=(get_htop get_vim get_tmux get_ssr get_peda get_chrome get_unzip get_unrar get_teamviewer get_sshd get_vscode get_skype get_mendeley get_clamav get_terminator get_screenfetch)

  for SW in ${SW_LIST[@]}; do
    prompt ${PWD}/$SW
  done
  popd
}

config_software(){
  pushd $LINUX_CONFIG_REPO/installation.d/conf.d
  CONF_LIST=(config_git config_tmux config_sshd)

  for CONF in ${CONF_LIST[@]}; do
    prompt ${PWD}/$CONF
  done
  popd
}

check_distribution

remove_gnomegames

build_dependency

install_bashrc

#install_extensions

get_software

config_software
