#!/usr/bin/env bash

ZIMDIR=${HOME}/.zim

echo "Installing Zim Framework"
$(which zsh) -c "source ${ZIMDIR}/zimfw.zsh init -q"

exit 0

