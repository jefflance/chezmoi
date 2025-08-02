#!/usr/bin/env bash

# include lib
. ${CHEZMOI_WORKING_TREE}/scripts/utils.sh


# usage
usage() {
  printf "\nUsage:\n"
  echo " --base         Install base packages"
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
      fd
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
      python-jupyter-core
      python-matplotlib
      python-plotly
      jupyter-nbclient
      jupyter-nbformat
    )
}

configure_quarto() {
  quarto install tinytex
}

# cli options
BASE=false
NVIM=false
LVIM=false
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
      --base)  BASE=true ;;
      --nvim)  NVIM=true ;;
      --lvim)  LVIM=true ;;
      --zsh)   ZSH=true ;;
      --latex) LATEX=true ;;
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
  "$NVIM" && install_nvim
  "$LVIM" && install_lvim
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
