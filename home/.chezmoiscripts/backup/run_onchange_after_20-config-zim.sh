#!/usr/bin/env bash

ZIMDIR=${HOME}/.zim

echo -e "\033[0;32m>>>>> Installing Zim Framework <<<<<\033[0m"
$(which zsh) -c "source ${ZIMDIR}/zimfw.zsh init -q"

echo -e "\033[0;32m>>>>> Finish zsh installation <<<<<\033[0m"

exit 0

