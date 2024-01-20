#!/usr/bin/env bash

set -euxo pipefail


if [ ! $(command -v nvim) ]; then
  {{- if ne .chezmoi.username "root" }}
    sudo yay -S --noconfirm neovim python-pynvim
  {{- else }}
    yay -S --noconfirm neovim python-pynvim
  {{- end }}
fi


LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
