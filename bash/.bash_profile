
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

## Load aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_keys ]; then
  . ~/.bash_keys
fi

## JAVA
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

## Remove vim warnings
export LC_ALL=en_US.UTF-8

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\]@\W\[\033[1;35m\][$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;35m\]]\[\033[0m\033[0;32m\] ✔\[\033[0m\033[0;32m\]\[\033[0m\] '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jamestjw/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/jamestjw/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jamestjw/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/jamestjw/Downloads/google-cloud-sdk/completion.bash.inc'; fi

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
