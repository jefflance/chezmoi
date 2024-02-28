# common.lib
#
# Common libray for local scripts
#



# CONSTANT VARIABLES
RESET=$(tput sgr0)

F_BOLD=$(tput bold)
F_UNDL=$(tput sgr 0 1)

C_BLK=$(tput setaf 0)
C_RED=$(tput setaf 1)
C_GRE=$(tput setaf 2)
C_YEL=$(tput setaf 3)
C_BLU=$(tput setaf 4)
C_MAG=$(tput setaf 5)
C_CYA=$(tput setaf 6)
C_WHI=$(tput setaf 7)

# common errors will cause the script to
# immediately fail, explicitly and loudly.
set -euxo pipefail

# function used to display colored message
cecho () {

    declare -A colors;
    declare -A formats;

    colors=(\
      ['black']=$(tput setaf 0)\
      ['red']=$(tput setaf 1)\
      ['green']=$(tput setaf 2)\
      ['yellow']=$(tput setaf 3)\
      ['blue']=$(tput setaf 4)\
      ['magenta']=$(tput setaf 5)\
      ['cyan']=$(tput setaf 6)\
      ['white']=$(tput setaf 7)\
    );

    formats=(\
      ['default']=$(tput sgr0)\
      ['inverse']=$(tput smso)\
      ['bold']=$(tput bold)\
    );

    local defaultMSG="No message passed.";
    local defaultColor="white";
    local defaultFormat="default";
    local defaultNewLine=true;

    while [[ $# -gt 1 ]];
    do
      key="$1";

      case $key in
        -c|--color)
            color="$2";
            shift;
        ;;
        -f|--format)
            format="$2";
            shift;
        ;;
        -n|--noline)
            newLine=false;
        ;;
        *)
            # unknown option
        ;;
      esac
      shift;
    done

    color=${color:-$defaultColor};   # Defaults to default color, if not specified.
    format=${format:-$defaultFormat};   # Defaults to default color, if not specified.
    newLine=${newLine:-$defaultNewLine};
    message=${1:-$defaultMSG};   # Defaults to default message.

    echo -en "${formats[$format]}${colors[$color]}";
    echo -en "$message";
    if [ "$newLine" = true ] ; then
        echo;
    fi
    tput sgr0; #  Reset text attributes to normal without clearing screen.

    return;
}



info1() {
  cecho -c 'blue' -f 'bold' "$@";
}

info2() {
  cecho -c 'cyan' -f 'bold' "$@";
}

success() {
  cecho -c 'green' "$@";
}

error() {
  cecho -c 'red' -f 'bold' "$@";
}

warning() {
  cecho -c 'yellow' "$@";
}



# vim: set filetype=bash :
