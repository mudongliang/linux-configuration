#!/bin/bash

# This script is only customized to Debian GNU/Linux
# since I only use Debian Stable on my destktop

#set -eux

export LINUX_CONFIG_REPO=$HOME/.config/linux_config_repo

SW_LIST=(
	get_htop
	get_vim
	get_tmux
	get_unzip
	get_unrar
	get_sshd
	get_screenfetch
#	get_vscode
#	get_peda
#	get_eletron-ssr
#	get_gnome-shell-extensions
)

CONF_LIST=(
	config_bashrc
	config_git
	config_tmux
	config_sshd
)

prompt() {
    read -p "[>] Will you '$1'?[y/N]" PMT
    case "${PMT}" in
        [yY])
	     true
	     ;;
	*)
	     false
	     ;;
    esac
}

build_dependency() {
    sudo apt -y install git curl wget gdebi trash-cli 
}

add_sudo_user() {
    su -c 'sed -i "48 i dzm91 ALL=(ALL) ALL" /etc/sudoers' 
}

check_distribution() {
    # /etc/os-release does exist in most Linux distributions, and BSD variants
    test -e /etc/os-release && os_release='/etc/os-release' || os_release='/usr/lib/os-release'
    . "${os_release}"
    case $ID in
        'ubuntu')
	    test -e /etc/sudoers || add_sudo_user
            sudo apt -y update; sudo apt -y upgrade;
            ;;
        'debian')
	    test -e /etc/sudoers || add_sudo_user
            sudo apt -y update; sudo apt -y upgrade;
            ;;
        *)
            echo "Your distribution - $NAME is not supported"
            exit
            ;;
    esac
}

update_mirror() {
    curl -s https://hustmirror.cn/get | sh
}

remove_preinstalled_software() {
    sudo apt purge -y gnome-2048 aisleriot gnome-chess five-or-more         \
         hitori iagno gnome-klotski lightsoff gnome-mahjongg gnome-mines    \
         gnome-nibbles quadrapassel four-in-a-row gnome-robots gnome-sudoku \
         swell-foop tali gnome-taquin gnome-tetravex gnome-maps
    sudo apt purge -y firefox-esr evolution
}

install_extensions() {
    ./bin/gnome-shell-extension-restore
}

install_software() {
    pushd $LINUX_CONFIG_REPO/get.d
    for SW in ${SW_LIST[@]}; do
        ${PWD}/$SW
    done
    popd
}

config_software() {
    pushd $LINUX_CONFIG_REPO/conf.d
    for CONF in ${CONF_LIST[@]}; do
        ${PWD}/$CONF
    done
    popd
}

check_distribution

build_dependency

# update software mirror on Debian/Ubuntu
# hustmirror-cli is not ready for now
# prompt "update software mirror" || update_mirror

prompt "remove preinstalled software" && remove_preinstalled_software

# prompt || install_extensions

prompt "install my favourite software" && install_software

prompt "configure my Linux system" && config_software
