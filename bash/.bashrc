# Spark path
export PATH=$PATH:/usr/local/spark/bin

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f "/Users/jamestjw/.ghcup/env" ] && source "/Users/jamestjw/.ghcup/env" # ghcup-env
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"

# Add ctags to PATH for scripting. Make sure this is the last PATH variable change.
alias ctags='/usr/local/bin/ctags'

