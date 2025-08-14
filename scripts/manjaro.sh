#!/usr/bin/env bash

# include lib
. ${CHEZMOI_WORKING_TREE}/scripts/utils.sh


# usage
usage() {
  printf "\nUsage:\n"
  echo " --base         Install base packages"
  echo " --devel        Install development languages"
  echo " --nvim         Install NeoVim and dependencies"
  echo " --zsh          Install zsh and dependencies"
  echo " --latex        Install latex and dependencies"
  echo " --ide          Install IDE's"
}

# packages to install
install_default() {
    packages=(
      base-devel
      curl
      gcc-fortran
      git
      pkgfile
      python-pip
      trash-cli
      unzip
      wl-clipboard
      wget
      xclip
      zip
    )
}

install_base() {
    packages+=(
      bubblewrap
      fzf
      pass
      imagemagick
      libyaml
      nerd-fonts
      noto-fonts-emoji
      ranger
      tmux
      ueberzug
      zoxide
    )
}

install_devel() {
    packages+=(
      go
      nodejs
      npm
      rust
    )
}

install_nvim() {
    packages+=(
      neovim
      python-pynvim
      fd
      ripgrep
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
      mermaid-cli
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
      texlive-plaingeneric
      texlive-humanities
      texlive-pstricks
    )
}

install_ide() {
    packages+=(
      code
      quarto-cli-bin
      python-cairosvg
      python-jupyter-core
      python-matplotlib
      python-pandas
      python-plotly
      jupyter-nbclient
      jupyter-nbformat
    )
}

# cli options
BASE=false
DEVEL=false
NVIM=false
ZSH=false
LATEX=false
IDE=false

if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

while [ "$#" -gt 0 ]; do
    case "$1" in
      --base)   BASE=true ;;
      --devel)  DEVEL=true ;;
      --nvim)   NVIM=true ;;
      --zsh)    ZSH=true ;;
      --latex)  LATEX=true ;;
      --ide)    IDE=true;;
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
  "$DEVEL" && install_devel
  "$NVIM" && install_nvim
  "$ZSH" && install_zsh
  "$LATEX" && install_latex
  "$IDE" && install_ide

  ## Install yay
  if [[ ! $(command -v yay) ]]; then
      ## Update system
      update_system
      install_binary "yay"
  fi

  # update_system "yay"

  ## Install packages
  for package in ${packages[@]}; do
      if [[ "$(yay -Qq $package 2> /dev/null)" != $package ]]; then
          install_binary $package "yay"
      else
          inf "${package} already installed."
      fi
  done

  exit 0
}

main "$@"
