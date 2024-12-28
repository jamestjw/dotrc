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

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/jamestjw/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/jamestjw/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
