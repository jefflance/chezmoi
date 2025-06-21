zle -N sudo-command-line

# Defined shortcut keys: [Esc] [Esc]
bindkey -M emacs '\es' sudo-command-line
bindkey -M vicmd '\es' sudo-command-line
bindkey -M viins '\es' sudo-command-line
