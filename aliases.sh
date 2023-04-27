export MYG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)/Development"

######################
# CUSTOM STARTS HERE #
######################

# Define a few Colours
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'

PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m' # No Color
BBLUE="\033[1;34m"

###########
# Aliases #
###########

# ls 
alias ls='ls --color=auto -a'
alias ll='ls -lha' # long format (l) and human readable file sizes (h)
alias la='ls -Alah'
alias l='ls -CFa'

# Dir 
alias home='cd'
alias documents='cd ~/documents'
alias downloads='cd ~/downloads'
alias linuxdoc='cd ~/linuxdoc'
alias music='cd ~/music'
alias pix='cd ~/pictures'
alias root='sudo -i'

# Sudo
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias purge='sudo apt-get remove --purge'
alias update='sudo apt-get update'
alias clean='sudo apt-get autoclean && sudo apt-get autoremove'
alias sources='(gksudo code /etc/apt/sources.list &)'

# chmod and permissions commands
alias mx='chmod a+x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'

# Misc
# alias a='alias'
alias c='clear'
alias h='htop'
alias x='exit'
alias bg='code ~/.bashrc'
alias pci='lspci'
alias ksf='killall swiftfox-bin'
alias del='rm --target-directory=$HOME/.Trash/'
alias font='fc-cache -v -f'

# Custom Oracle related
alias root='/usr/local/packages/aime/ias/run_as_root "su root"'

#Automatically do an ls after each cd
#cd() {
#  if [ -n "$1" ]; then
#    builtin cd "$@" && ll
#  else
#    builtin cd ~ && ll
#  fi
#}

##################
# WELCOME SCREEN #
##################

#clear
#echo -ne "Hello, $USER. today is, "; date
#export PS1="\[\e]2;\u@\H \w\a\e[30;1m\]>\[\e[0m\] "
#export PS1="\[\e]2;\u@\H \w\a\n----\nPath:\w (bash)\n----\n\u@\H $> \]"



## Applications
alias cal="cal -m -3"
# Copy to clipboard.
alias xclips="xclip -selection c"

## Git
alias git="nice git"
alias gst="git stash"
alias gsta="git status --short --branch"
#alias gsu="git submodule update --recursive --merge"
alias gdf="git diff"
alias gdt="git difftool"
alias glo="git log"
alias gps="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gci="git commit"
alias gad="git add"
alias grm="git rm"
alias gmv="git mv"
alias gtg="git tag"
alias gbr="git branch"
alias gs="git svn"

# Mine
alias gsu="git submodule update"
alias gsui="git submodule update --init"
alias gsur="git submodule update --recursive"
alias gsuir="git submodule update --init --recursive"
alias gsure="git submodule update --remote"
alias gpr="git pull --rebase origin"
alias gprm="git pull --rebase origin main"
alias gcb="git checkout -b"
alias gpsf="git push -f"
alias gmc='git merge --continue'
alias gma='git merge --abort'
alias gms='git merge --skip'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias grs='git rebase --skip'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcps='git cherry-pick --skip'
alias gca='git commit --amend --no-edit'
alias gcl='git clean -xfd'
# Shows the number of files changed and number of lines added/removed since the last commit.
alias gdiff='git diff --shortstat HEAD'
alias glog='git log --graph --oneline --decorate'


# Shows the number of of changes between head and n commits back
gdiffn() {
    local n=$1
    echo "git diff --shortstat HEAD~${n} HEAD"
    git diff --shortstat HEAD~${n} HEAD
}
gdiffhash() {
    local n=$1
    echo "git diff --shortstat $n HEAD"
    git diff --shortstat $n HEAD
}
gdiffo() {
    # Gets the diff between local and remote branch.
    local cur_branch=$(git rev-parse --abbrev-ref HEAD)
    git diff --shortstat origin/$cur_branch HEAD
}

get_myg_release_cwd() {
    git describe --tags --abbrev=0 --match MYG* | sed -e 's_MYG/__g'
}

get_myg_release() {
    [[ $1 = cwd ]] && git describe --tags --abbrev=0 --match MYG* | sed -e 's_MYG/__g' && return
    echo $(cd ~/repos/Development && git describe --tags --abbrev=0 --match MYG* | sed -e 's_MYG/__g')
}

gprr() {
    local cwd=cwd
    [[ $1 == cwd ]] && cwd=true && shift
    local version="$1"

    [[ -z $version ]] && version=$(get_myg_release_cwd)
    # [[ -z $version ]] && version=$(get_myg_release $cwd)
    # [[ -z $version ]] && version=$(geo --raw-output dev release)
    [[ -z $version ]] && echo 'Error: no version specified' && return
    echo pulling release $version
    # Add the .0 suffix to the version if it is missing (e.g. 8 => 8.0);
    [[ ! $version =~ \.0$ ]] && version+='.0'
    echo "git pull --rebase origin release/$version"
    git pull --rebase origin release/$version
}

# Network
alias n="netstat -np tcp"
alias mtr="mtr -t"
alias nmap="nmap -v -v -T5"
alias nmapp="nmap -P0 -A --osscan_limit"
alias pktstat="sudo pktstat -tBFT"
# List listening ports
alias lports="sudo lsof -i -P -n | grep LISTEN"

# Bashrc
alias ebrc='code ~/.bashrc'
alias srcb="source ~/.bashrc"
alias src="source ~/.bashrc"
alias sud='su dawsonmyers'

# Docker
alias dcc='docker-compose'
alias dcch="dcc -f ${HOME}/Code/Development/Checkmate/Docker/high-avail.docker-compose.yml"

# geo-cli
###############################################################################
alias gd='geo db'
alias gdp='geo db ps'
alias gds='geo db start'
alias gdr='geo db rm'
alias ga='geo analyze'
# Run roslyn analyzer
alias gar='geo analyze 5'
# Run all analyzers in batch mode
alias gaab='geo analyze -bas'
# Run all analyzers, skip (-s) long running analyzers
alias gaa='geo analyze -as'
# alias gaa='geo analyze 0 1 2 3 4 5 6 7'
alias gcd='geo cd geo'
alias cdmyg='geo cd dev'
alias cddev='geo cd dev'
alias dcd='geo cd dev'
alias cdmyg='geo cd dev'

# C#
alias csr='csharprepl'

# MyGeotab
alias buildall="dotnet build -c Release -m:1 ${MYG_DIR}/All.sln"

alias sconf="code ~/GEOTAB/Checkmate/server.config"

alias e='evar '
alias ee='echo '

# Copy to clipboard.
alias setclip="xclip -selection c"
# Paste from clipboard.
alias getclip="xclip -selection c -o"