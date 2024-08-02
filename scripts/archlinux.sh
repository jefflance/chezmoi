#!{{ lookPath "bash" }}

# Logging function
log() {
  printf "$(tput setaf 4)$(tput bold)>>>>> %s <<<<<$(tput sgr0)\n" "$1"
}

inf() {
  printf "$(tput setaf 2)╚═══ᐳ $(tput sgr 0 1)$(tput setaf 2)%s$(tput sgr0)\n" "$1"
}

err() {
  printf "$(tput setaf 9)$(tput bold)>>>>> %s ! <<<<<$(tput sgr0)\n" "$1"
}

log "Executing $0..."

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


{{ if ne .chezmoi.username "root" -}}
  ## Update system
  inf "updating system..."
  sudo pacman -Syu --noconfirm --quiet

  ## Install yay
  if [ ! $(command -v yay) ]; then
    inf "installing yay..."
    sudo pacman -S --needed --noconfirm --quiet git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    rm -rf /tmp/yay
  fi

  ## Install packages
  for package in ${packages[@]}; do
    if [ "$(yay -Qq $package 2> /dev/null)" != $package ]; then
      inf "installing ${package}..."
      yay -S --noconfirm --removemake --quiet $package
    fi
  done
{{ else -}}
  err "you may not run this script as root" 
{{- end}}





