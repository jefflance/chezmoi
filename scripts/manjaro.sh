#!/usr/bin/env bash

# include lib
. ${CHEZMOI_WORKING_TREE}/scripts/utils.sh


# usage
usage() {
  printf "\nUsage:\n"
  echo " --base         Install base pacakges"
  echo " --nvim         Install deps for NeoVim"
  echo " --zsh          Install deps for zsh"
  echo " --latex        Install deps for latex"
}

# packages to install
install_default() {
    packages=(
      base-devel
      git
    )
}

install_base() {
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
}

install_nvim() {
    packages+=(
      neovim
      python-pip
      python-pynvim
      ripgrep
    )
}

install_lvim() {
    packages+=(
      go
      nodejs
      npm
      python
      rust
      tree-sitter-cli
    )
}

install_zsh() {
    packages+=(
      zsh
    )
}

install_latex() {
    packages+=(
      texlive-basic
      texlive-latex
      texlive-binextra
      texlive-latexrecommended
      texlive-latexextra
      texlive-fontsrecommended
      texlive-fontsextra
      texlive-luatex
      texlive-mathscience
      texlive-lang
    )
}

# cli options
BASE=false
NVIM=false
LVIM=false
ZSH=false
LATEX=false

if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

while [ "$#" -gt 0 ]; do
    case "$1" in
      --base)  BASE=true ;;
      --nvim)  NVIM=true ;;
      --lvim)  LVIM=true ;;
      --zsh)   ZSH=true ;;
      --latex) LATEX=true ;;
      *)
          usage
          exit 1
      ;;
    esac
    shift
done

main() {
  install_default
  "$BASE" && install_base
  "$NVIM" && install_nvim
  "$LVIM" && install_lvim
  "$ZSH" && install_zsh
  "$LATEX" && install_latex
  
  ## Install yay
  if [ ! $(command -v yay) ]; then
      ## Update system
      update_system
      install_binary "yay"
  fi

  update_system "yay"

  ## Install packages
  for package in ${packages[@]}; do
      if [ "$(yay -Qq $package 2> /dev/null)" != $package ]; then
          install_binary $package "yay"
      else
          inf "${package} already installed."
      fi
  done

  exit 0
}

main "$@"
