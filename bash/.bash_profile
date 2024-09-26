[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

## Load aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if [ -f ~/.bash_keys ]; then
	. ~/.bash_keys
fi

# Created by `pipx` on 2024-09-17 00:45:40
export PATH="$PATH:/home/james/.local/bin"

. "$HOME/.atuin/bin/env"

[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc"
