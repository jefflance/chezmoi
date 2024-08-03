#!/usr/bin/env bash

# include lib
. ${CHEZMOI_WORKING_TREE}/scripts/utils.sh


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
inf "Updating system..."
sudo pacman -Syu --noconfirm --quiet

## Install yay
if [ ! $(command -v yay) ]; then
  inf "Installing yay..."
  install_binary "yay"
fi

## Install packages
for package in ${packages[@]}; do
  if [ "$(yay -Qq $package 2> /dev/null)" != $package ]; then
    inf "Installing ${package}..."
    install_binary $package "yay"
  fi
done

inf "Packages installed."