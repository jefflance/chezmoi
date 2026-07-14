#
# Personal aliases
#


#
# Admin
#

alias udvrld='sudo udevadm control --reload-rules && sudo udevadm trigger'


#
# Editors
#

[[ $(command -v nvim) ]] && alias vim='nvim'
[[ $(command -v chezmoi) ]] && alias edit='chezmoi edit --watch'

#
# Mail, internet
#

alias mutt='neomutt -f ${HOME}/Mail/jeff.lance@mala.fr/inbox/'
alias neomutt='neomutt -f ${HOME}/Mail/jeff.lance@mala.fr/inbox/'


#
# Utilities
#

if [[ "$TERM" == 'xterm-kitty' ]]; then
  ## kssh
  # Use this when your terminfo isn't recognized on remote hosts.
  # See: https://sw.kovidgoyal.net/kitty/faq/#i-get-errors-about-the-terminal-being-unknown-or-opening-the-terminal-failing-when-sshing-into-a-different-computer
  alias -g kssh="kitty +kitten ssh"
  compdef kssh='ssh'
  # Use this if kssh fails
  alias kssh-slow="infocmp -a xterm-kitty | ssh myserver tic -x -o \~/.terminfo /dev/stdin"

  # Change the colour theme
  alias kitty-theme="kitty +kitten themes"
fi

[[ $(command -v trash) ]] && alias rm='trash-put'
[[ $(command -v dfc) ]] && alias df='dfc'
[[ $(command -v eza) ]] && alias ls='eza -l --icons=always'

alias ip='ip -c'                         # ip address
alias md='mkdir -p'                      # mkdir alias
alias open='xdg-open'                    # open files
alias pips='pip_search'                  # pip search tool
alias rs='rsync -Pavzl'                  # rsync shortcut
alias t='tmux'                           # tmux
alias ta='t a -t'                        # tmux attach to a session
alias tl='t ls'                          # tmux list sessions
alias tn='t n -t'                        # tmux new session
alias vs='transcode-video --scan'        #
alias xcolor='xcolor | xclip -i'         # xcolor
alias yd='yt-dlp'                        # yt-dlp best download


#
# Shortcuts
#

hash -d crs="${HOME}/Cours"              # cours
hash -d doc="${HOME}/Documents"          # documents
hash -d dot="$(chezmoi source-path)"     # dotfiles


#
# Environment
#

# interactive comments
setopt interactivecomments
bindkey '^R' history-incremental-search-backward
