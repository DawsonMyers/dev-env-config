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

alias ll='ls -lh' # long format (l) and human readable file sizes (h)
alias la='ls -A'
alias l='ls -CF'

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
alias sources='(gksudo geany /etc/apt/sources.list &)'

# chmod and permissions commands
alias mx='chmod a+x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'

# Misc
alias a='alias'
alias c='clear'
alias h='htop'
alias x='exit'
alias bg='geany ~/.bashrc'
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

gprr() {
    git pull --rebase origin release/$1
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
alias gaab='geo analyze -b -a'
# Run all analyzers
alias gaa='geo analyze -a'
# alias gaa='geo analyze 0 1 2 3 4 5 6 7'

# C#
alias csr='csharprepl'

# MyGeotab
alias buildall="dotnet build -c Release -m:1 ${MYG_DIR}/All.sln"

alias sconf="code ~/GEOTAB/Checkmate/server.config"