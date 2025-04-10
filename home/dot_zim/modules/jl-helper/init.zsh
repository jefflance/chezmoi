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

alias vim='lvim'                         # redirect vim to nvim
alias edit='chezmoi edit'

#
# Mail, internet
#

alias mutt='neomutt -f ${HOME}/Mail/jeff.lance@mala.fr/inbox/'
alias neomutt='neomutt -f ${HOME}/Mail/jeff.lance@mala.fr/inbox/'


#
# Utilities
#

[[ $(command -v trash) ]] && alias rm='trash-put'
alias ip='ip -c'                         # ip address
alias ls='eza -l --icons=always'            # ls aliased to eza, exa fork
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

hash -d crs="${HOME}/Documents/cours"    # cours
hash -d doc="${HOME}/Documents"          # documents
hash -d dot="$(chezmoi source-path)"     # dotfiles


#
# Environment
#

# interactive comments
setopt interactivecomments
bindkey '^R' history-incremental-search-backward
