[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

## Load aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_keys ]; then
  . ~/.bash_keys
fi

## JAVA
## export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export JAVA_HOME=$(/usr/libexec/java_home)

## Remove vim warnings
export LC_ALL=en_US.UTF-8

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\]@\W\[\033[1;35m\][$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;35m\]]\[\033[0m\033[0;32m\] ✔\[\033[0m\033[0;32m\]\[\033[0m\] '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Google Creds
export GOOGLE_APPLICATION_CREDENTIALS=~/.gcloud/keyfile.json

# Go Path
export GOPATH=~/Documents/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

# Added by install_latest_perl_osx.pl
[ -r ~/.bashrc ] && source ~/.bashrc

# OPENSSL
export PATH="/usr/local/opt/openssl/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

# Circle CI Git approval tool
export CI_CONFIG_PATH=~/.ci_config

# Add path to Rust binaries (executables from my projects)
export PATH=$PATH:/Users/`whoami`/rust/binaries

##
# Your previous /Users/jamestjw/.bash_profile file was backed up as /Users/jamestjw/.bash_profile.macports-saved_2020-11-19_at_22:22:11
##

# MacPorts Installer addition on 2020-11-19_at_22:22:11: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts Installer addition on 2020-11-19_at_22:22:11: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.

# Add postgres to path
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Add SML to path
export PATH="$PATH:/usr/local/smlnj/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# opam configuration
test -r /Users/jamestjw/.opam/opam-init/init.sh && . /Users/jamestjw/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jamestjw/google-cloud-sdk/path.bash.inc' ]; then . '/Users/jamestjw/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jamestjw/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/jamestjw/google-cloud-sdk/completion.bash.inc'; fi

# Add gcloud tools to path
export PATH="$HOME/google-cloud-sdk/bin/:$PATH"

# Add pyenv installations to path
export PATH="$HOME/.pyenv/shims:${PATH}"

export GPG_TTY=$(tty)

# Add gambit scheme to path (10 Jan 2023)
export PATH="$HOME/g4.9.4/bin:$PATH"

# Guile (14 Fev 2023)
export GUILE_LOAD_PATH="$(brew --prefix)/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="$(brew --prefix)/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="$(brew --prefix)/lib/guile/3.0/extensions"

export GUILE_LOAD_PATH="/Users/jamestjw/Documents/source/scheme-lsp-server/guile:$GUILE_LOAD_PATH"
export GUILE_LOAD_COMPILED_PATH="/Users/jamestjw/Documents/source/scheme-lsp-server/guile:$GUILE_LOAD_COMPILED_PATH"

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jamestjw/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jamestjw/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jamestjw/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jamestjw/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Cabal installations
export PATH=~/.cabal/bin:$PATH

# Emacs doom
export PATH=~/.emacs.doom/bin:$PATH

export PATH="$PATH:/Users/jamestjw/Library/Application Support/Coursier/bin"

export PATH="$PATH:/Users/jamestjw/Documents/source/pypy3.10-v7.3.13-macos_x86_64/bin"

# Prevent brew from automatically updating dependencies when installing new
# packages
export HOMEBREW_NO_AUTO_UPDATE=1
