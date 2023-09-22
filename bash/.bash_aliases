# Aliases
alias ll='ls -ahlF'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ggp="git reflog | ggrep -Pio '(?<=moving from ).+(?= to)' | uniq | head -n10"
alias cdd="cd ~/Documents"
alias cdmp="cd ~/Documents/myprojects"
alias cr='git st | awk '\''{for (i=0; i<=NF; i++) {if ($i == "branch") { printf $(i+1);exit}}}'\'' | pbcopy && echo `pbpaste`'
alias pwd='pwd | perl -ple "s/[\r\n]//g" | pbcopy && echo `pbpaste`'

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
mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

gm ()
{
	branch=$(git st | awk '''{for (i=0; i<=NF; i++) {if ($i == "branch") { printf $(i+1);exit}}}''')	
	git co $1
	git pull origin $1
	git merge $branch --no-edit
	git push
}

function pkill() {
    local pid
    pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
    kill -9 $pid
    echo -n "Killed $1 (process $pid)"
}

sourceenv () {
	source $1/bin/activate
}

# CCLS
alias cpccls='cp /Users/jamestjw/.default_ccls .ccls'

# Run ada CI
# alias cia='echo "Sleeping 5secs..." && sleep 5 && ci_manager approve $(cr)'

# CD google drive
alias cdg='cd "/Users/jamestjw/Library/CloudStorage/GoogleDrive-youknowjamest@gmail.com/Mon Drive"'

avg_time_alt() {
    local -i n=$1
    local foo real sys user
    shift
    (($# > 0)) || return;
    { read foo real; read foo user; read foo sys ;} < <(
        { time -p for((;n--;)){ "$@" &>/dev/null ;} ;} 2>&1
    )
    printf "real: %.5f\nuser: %.5f\nsys : %.5f\n" $(
        bc -l <<<"$real/$n;$user/$n;$sys/$n;" )
}

alias cdcs="open \"/Volumes/GoogleDrive/Mon Drive/Books/Computer Science\""

# nvim
alias nv="nvim"
alias vi="vim"
alias vim="nv"
alias nvconf="nvim ~/.config/nvim"

# Emacs
alias dr="doom run"
