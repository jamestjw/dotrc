# Aliases
alias ll='ls -ahlF'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ggp="git reflog | ggrep -Pio '(?<=moving from ).+(?= to)' | uniq | head -n10"
alias cdd="cd ~/Documents"
alias cdmp="cd ~/Documents/myprojects"
alias cdp='cd `pbpaste`'
alias cds="cd ~/Documents/sollum"
alias cr='git st | awk '\''{for (i=0; i<=NF; i++) {if ($i == "branch") { printf $(i+1);exit}}}'\'''
# alias pwd='pwd | perl -ple "s/[\r\n]//g" | pbcopy && echo `pbpaste`'

# Git aliases
alias gitm='git checkout main'
alias gdh='git diff HEAD'
alias gitpsetup='git push --set-upstream origin $(git branch --show-current)'
alias gitaa='git add -u && git commit --amend'

# Rails Aliases
# alias be='bundle exec'
# alias railsc='cd ~/Documents/Kaodim/ada && bundle exec rails c'
# alias srspec='bundle exec spring rspec'
# alias rspecst="srspec `git status | ggrep -Pio '(?<=modified:)\s+(spec/)(?!factories).*' | tr '\n' ' '` "
# alias rspecall="srspec `git diff master...HEAD | ggrep -Po '(?<=\+\+\+ b/)(spec/)(?!factories).*' | tr '\n' ' '`"

# Functions
mkcdir() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

function pkill() {
  local pid
  pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
  kill -9 $pid
  echo -n "Killed $1 (process $pid)"
}

sourceenv() {
  source $1/bin/activate
}

avg_time_alt() {
  local -i n=$1
  local foo real sys user
  shift
  (($# > 0)) || return
  {
    read foo real
    read foo user
    read foo sys
  } < <(
    { time -p for (( ; n--; )); do "$@" &>/dev/null; done; } 2>&1
  )
  printf "real: %.5f\nuser: %.5f\nsys : %.5f\n" $(
    bc -l <<<"$real/$n;$user/$n;$sys/$n;"
  )
}

# nvim
alias nv="nvim"
alias vim="nvim"
alias nvconf="nvim ~/.config/nvim"

# Emacs
alias dr="doom run"
