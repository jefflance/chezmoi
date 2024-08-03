#!/usr/bin/env bash

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

# Function to determine the package manager if not specified
determine_package_manager() {
    if [ command -v apt-get &>/dev/null ]; then
        echo "apt"
    elif [ command -v pamac &>/dev/null ]; then
        echo "pamac"
    elif [ command -v yay &>/dev/null ]; then
        echo "yay"
    elif [ command -v pacman &>/dev/null ]; then
        echo "pacman"
    else
        err "No supported package manager found."
        exit 1
    fi
}

# Simple abstraction to install a binary using a supported package manager
install_binary() {
    # Example usage:
    # install_binary "fzf"
    # install_binary "fzf" "dnf"

    local package_name="${1}"
    local package_manager="${2}"

    # If the package manager is not specified, determine it
    if [[ -z "${package_manager}" ]]; then
        package_manager=$(determine_package_manager)
    fi

    # Install the package using the determined or specified package manager
    inf "installing ${package_name} using ${package_manager}..."

    case "${package_manager}" in
        apt)
            sudo apt-get install --yes --no-install-recommends --ignore-missing --fix-broken -qq "${package_name}" || {
                err "Installation failed."
                exit 1
            }
        ;;
        pacman)
            sudo pacman -S --needed --noconfirm --quiet "${package_name}" || {
                err "Installation failed."
                exit 1
            }
        ;;
        pamac)
            sudo pamac --no-confirm "${package_name}" || {
                err "Installation failed."
                exit 1
            }
        ;;
        yay)
            yay -S --noconfirm --removemake --quiet "${package_name}" || {
                err "Installation failed."
                exit 1
            }
        ;;
        *)
            err "Unsupported package manager: ${package_manager}"
            exit 1
        ;;
    esac

    inf "installation of ${package_name} completed successfully."
}

update_system() {
    local package_manager="${1}"

    # If the package manager is not specified, determine it
    if [[ -z "${package_manager}" ]]; then
        package_manager=$(determine_package_manager)
    fi

    # Install the package using the determined or specified package manager
    inf "updating system using ${package_manager}..."

    case "${package_manager}" in
        apt)
            sudo -E apt update -qq && sudo -E apt upgrade --yes -qq || {
                err "Installation failed."
                exit 1
            }
        ;;
        pacman)
            sudo pacman -Syu --noconfirm --removemake --quiet || {
                err "Installation failed."
                exit 1
            }
        ;;
        pamac)
            sudo pamac update --aur --no-confirm && sudo pamac upgrade --aur --no-confirm || {
                err "Installation failed."
                exit 1
            }
        ;;
        yay)
            yay -Syu --noconfirm --removemake --quiet || {
                err "Installation failed."
                exit 1
            }
        ;;
        *)
            err "Unsupported package manager: ${package_manager}"
            exit 1
        ;;
    esac

    inf "system update completed successfully."
}
