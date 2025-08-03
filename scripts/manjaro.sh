#!/usr/bin/env bash

# include lib
. ${CHEZMOI_WORKING_TREE}/scripts/utils.sh


# usage
usage() {
  printf "\nUsage:\n"
  echo " --base         Install base packages"
  echo " --devel        Install development languages"
  echo " --nvim         Install deps for NeoVim"
  echo " --zsh          Install deps for zsh"
  echo " --latex        Install deps for latex"
  echo " --quarto       Install deps for quarto"
  echo " --vscode       Install deps for VSCode"
}

# packages to install
install_default() {
    packages=(
      base-devel
      curl
      git
      pkgfile
      trash-cli
      unzip
      wget
      zip
    )
}

install_base() {
    packages=(
      bubblewrap
      fzf
      pass
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
      lua
      nodejs
      npm
      python
      rust
    )
}

install_nvim() {
    packages+=(
      fd
      luarocks
      neovim
      python-pip
      python-pynvim
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

install_vscode() {
    packages+=(
      code
    )
}

install_quarto() {
    packages+=(
      quarto-cli-bin
      jupyter-nbclient
      jupyter-nbformat
      python-jupyter-core
      python-matplotlib
      python-pandas
      python-plotly
    )
}

configure_quarto() {
  quarto install tinytex
}

# cli options
BASE=false
DEVEL=false
NVIM=false
ZSH=false
LATEX=false
VSCODE=false
QUARTO=false

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
      --vscode) VSCODE=true;;
      --quarto) QUARTO=true;;
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
  "$VSCODE" && install_vscode
  if [[ $QUARTO == true ]]; then
      install_quarto
      configure_quarto
  fi

  ## Install yay
  if [[ ! $(command -v yay) ]]; then
      ## Update system
      update_system
      install_binary "yay"
  fi

  update_system "yay"

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
