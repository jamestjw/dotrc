# Aliases
alias ll='ls -ahlF'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ggp="git reflog | grep -Pio '(?<=moving from ).+(?= to)' | uniq | head -n10"
alias cdd="cd ~/Documents"
alias cdmp="cd ~/Documents/myprojects"
alias cdp='cd `xclip -selection clipboard`'
alias cds="cd ~/Documents/sollum"
alias cpecho='xclip -selection clipboard -rmlastnl && xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard'
alias cr='git branch --show-current | cpecho'
# Copy `pwd` output to clipboard without newline and echo it from the clipboard
alias pwd='builtin pwd | cpecho'
alias lg='lazygit'

# Git aliases
alias gitm='git checkout main'
alias gdh='git diff HEAD'
alias gitaa='git add -u && git commit --amend'
alias gprush='git pull --rebase origin main && git push'

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

# Mount google drive using rclone, set up config first with `google-drive` as
# the name
alias mnt_gdrive="rclone mount google-drive: ~/drive/"

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
