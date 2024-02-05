zimfw() { source /home/jeff/.zim/zimfw.zsh "${@}" }
zmodule() { source /home/jeff/.zim/zimfw.zsh "${@}" }
fpath=(/home/jeff/.zim/modules/git/functions /home/jeff/.zim/modules/archive/functions /home/jeff/dotfiles/conf.d/zim/modules/jl-helper/functions /home/jeff/dotfiles/conf.d/zim/modules/sudo/functions /home/jeff/.zim/modules/zsh-kitty/functions /home/jeff/.zim/modules/utility/functions /home/jeff/.zim/modules/git-info/functions /home/jeff/.zim/modules/zim-starship/functions ${fpath})
autoload -Uz -- git-alias-lookup git-branch-current git-branch-delete-interactive git-branch-remote-tracking git-dir git-ignore-add git-root git-stash-clear-interactive git-stash-recover git-submodule-move git-submodule-remove archive lsarchive unarchive cpv dip gi gip shrinkpdf update_auth_sock sudo-command-line mkcd mkpw coalesce git-action git-info
source /home/jeff/.zim/modules/environment/init.zsh
source /home/jeff/.zim/modules/input/init.zsh
source /home/jeff/.zim/modules/zsh-completions/zsh-completions.plugin.zsh
source /home/jeff/dotfiles/conf.d/zim/modules/buku/init.zsh
source /home/jeff/.zim/modules/completion/init.zsh
source /home/jeff/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/jeff/.zim/modules/git/init.zsh
source /home/jeff/.zim/modules/termtitle/init.zsh
source /home/jeff/.zim/modules/archive/init.zsh
source /home/jeff/dotfiles/conf.d/zim/modules/manjaro/init.zsh
source /home/jeff/dotfiles/conf.d/zim/modules/jl-helper/init.zsh
source /home/jeff/dotfiles/conf.d/zim/modules/sudo/init.zsh
source /home/jeff/.zim/modules/z/z.sh
source /home/jeff/.zim/modules/zsh-kitty/zsh-kitty.plugin.zsh
source /home/jeff/.zim/modules/utility/init.zsh
source /home/jeff/.zim/modules/exa/init.zsh
source /home/jeff/.zim/modules/fzf/init.zsh
source /home/jeff/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/jeff/.zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
source /home/jeff/.zim/modules/steeef/steeef.zsh-theme
source /home/jeff/.zim/modules/zim-starship/init.zsh
