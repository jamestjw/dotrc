[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

## Load aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

export EDITOR='vim'

# Spark path
export PATH=$PATH:/usr/local/spark/bin

################################### Ruby START #################################

# So I have stuff for two different version managers since the one I use depends
# on my machine

# RVM:
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# rbenv:
[[ -f $HOME/.rbenv/bin/rbenv ]] && eval "$($HOME/.rbenv/bin/rbenv init -)"

################################### Ruby END## #################################


[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# Added by Toolbox App
[[ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]] && export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# Add scripts to path
export PATH="$PATH:$HOME/scripts"

# Add ctags to PATH for scripting. Make sure this is the last PATH variable change.
alias ctags='/usr/local/bin/ctags'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

## Remove vim warnings
export LC_ALL=en_US.UTF-8

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\]@\W\[\033[1;35m\][$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;35m\]]\[\033[0m\033[0;32m\] ✔\[\033[0m\033[0;32m\]\[\033[0m\] '

export NVM_DIR="$HOME/.nvm"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
export PATH="$PATH:$NVM_BIN"

# Google Creds
export GOOGLE_APPLICATION_CREDENTIALS=~/.gcloud/keyfile.json

# Go Path
export GOPATH=~/Documents/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

# OpenSSL
export PATH="/usr/local/opt/openssl/bin:$PATH"

# Rust
[ -s "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"

# Add postgres to path
[[ -d /Applications/Postgres.app ]] && export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Add SML to path
export PATH="$PATH:/usr/local/smlnj/bin"

# opam configuration
test -r ~/.opam/opam-init/init.sh && . ~/.opam/opam-init/init.sh >/dev/null 2>/dev/null || true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.bash.inc' ]; then . '~/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.bash.inc' ]; then . '~/google-cloud-sdk/completion.bash.inc'; fi

# Add gcloud tools to path
export PATH="$HOME/google-cloud-sdk/bin/:$PATH"

## PYTHON BEGIN
# Pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PYTHON_CONFIGURE_OPTS='--enable-optimizations --with-lto'
export PYTHON_CFLAGS='-march=native -mtune=native'
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
[[ -d $PYENV_ROOT/shims ]] && export PATH="$PYENV_ROOT/shims:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

export PATH="~/.local/bin:$PATH"

## PYTHON END

# So that `fc` command correctly uses neovim
export FCEDIT=nvim

export GPG_TTY=$(tty)

# Add gambit scheme to path (10 Jan 2023)
export PATH="$HOME/g4.9.4/bin:$PATH"

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

# Cabal installations
export PATH=~/.cabal/bin:$PATH

# Emacs doom
export PATH=~/.emacs.doom/bin:$PATH

export PATH="$PATH:~/Library/Application Support/Coursier/bin"

export PATH="$PATH:~/Documents/source/pypy3.10-v7.3.13-macos_x86_64/bin"

# Prevent brew from automatically updating dependencies when installing new
# packages
export HOMEBREW_NO_AUTO_UPDATE=1

# Created by `pipx` on 2024-09-17 00:45:40
export PATH="$PATH:$HOME/.local/bin"

# Initiate zoxide (better `cd`)
eval "$(zoxide init bash --no-cmd)"

eval "$(fzf --bash)"

# Setup atuin (shell history)
. "$HOME/.atuin/bin/env"
eval "$(atuin init bash --disable-up-arrow)"

# Setup `ondir` hooks
if command -v ondir 2>&1 >/dev/null; then
  cd() {
    builtin cd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
  }
  # Define zoxide command (we skipped the creation of this with `--no-cmd`)
  z() {
    __zoxide_z "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
  }
  pushd() {
    builtin pushd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
  }
  popd() {
    builtin popd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
  }
else
  # Define zoxide command (we skipped the creation of this with `--no-cmd`)
  z() {
    __zoxide_z "$@"
  }
fi

zi() {
  __zoxide_zi "$@"
}
