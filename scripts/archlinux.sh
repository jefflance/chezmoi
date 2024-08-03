#!/usr/bin/env bash

FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
SCRIPT_DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"

# include lib
. $SCRIPT_DIRECTORY/utils.sh


# Packages to install
packages=(
    bubblewrap
    curl
    fzf
    pass
    libyaml
    ranger
    tmux
    trash-cli
    ueberzug
    unzip
    wget
    zip
    zoxide
)


## Update system
inf "updating system..."
sudo pacman -Syu --noconfirm --quiet

## Install yay
if [ ! $(command -v yay) ]; then
  inf "installing yay..."
  install_binary "yay"
fi

## Install packages
for package in ${packages[@]}; do
  if [ "$(yay -Qq $package 2> /dev/null)" != $package ]; then
    inf "installing ${package}..."
    install_binary $package "yay"
  fi
done
