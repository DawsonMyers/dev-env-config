#!/bin/bash
# export DEV_CONFIG_DIR="$HOME/dev-env-config"
export DEV_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export MYG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)/Development"

# Source this file in .bashrc
. $DEV_CONFIG_DIR/util/log.sh
. $DEV_CONFIG_DIR/aliases.sh
. $DEV_CONFIG_DIR/scripts/bashrc-utils.sh
###################################################################################################

running_geo_cli_container() {
    name=$(docker ps --format '{{ .Names }}')
    name=${name##geo_cli_db_postgres_}
    [[ -n $name ]] && echo "[$name]"
}

# Bash prompt
# Have to run install.sh first
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

. $DEV_CONFIG_DIR/prompt.sh


export HISTTIMEFORMAT="%F %T "
export HISTFILESIZE=20000
export HISTSIZE=20000
export HISTCONTROL=$HISTCONTROL:ignoredups

# https://docstore.mik.ua/orelly/unix3/upt/ch31_05.htm
[[ -d ~/Code ]] && CDPATH=:~/Code
[[ -d ~/repos ]] && CDPATH=:~/repos

# Allows for typing the start of a command, for example gcloud then using the up and down arrows to cycle through your history for matching commands
# bind '"\e[A": history-search-backward'
# bind '"\e[A": history-search-backward'
# bind '"\e[B": history-search-forward'


# use 'showkey -a' command to find out what the keycodes are
# ctrl+up = \e[1;5A
# ctrl+down = \e[1;5B
# ctrl+right = \e[1;5C
# ctrl+left = \e[1;5D

# Only load in an interactive terminal.
if [[ $- =~ i ]]; then
    bind '"\e[1;5A":history-search-backward'
    bind '"\e[1;5B":history-search-forward'
    bind '"\e[1;5C":forward-word'
    bind '"\e[1;5D":backward-word'
fi

# Store cmds to history  as they are entered
shopt -s histappend  
# append_to_history() { history -a; }
# [[ ! $PROMPT_COMMAND =~ append_to_history ]] && PROMPT_COMMAND+=';append_to_history;'

# Add GitLab PAT environment variables.
[[ -f $DEV_CONFIG_DIR/include/gitlab/gitlab-pat ]] && . $DEV_CONFIG_DIR/include/gitlab/gitlab-pat

gcor() {
    (
        geo cd dev
        git checkout release/$1.0
    )
}

# Enable Starship
# eval "$(starship init bash)"

export EDITOR='code -nw '

disk_analyzer() {
    sudo baobab
}

resize_swap() {
    set -e
    local swapsize_gb=$1
    sudo swapoff -a
    [[ -f /swapfile ]] && sudo sudo rm /swapfile
    sudo fallocate -l ${swapsize_gb}G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
}

mkdir -p ~/.bash_completion

for completion_file in ~/.bash_completion/*; do
    . "$completion_file"
done

# if [ -f ~/bin/sensible.bash ]; then
#    source ~/bin/sensible.bash
# fi

# Implicit cd
shopt -s autocd
# Correct minor errors in the spelling of a directory
shopt -s cdspell
shopt -s dirspell
# Activate recursive globbing
shopt -s globstar

# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL="erasedups:ignoreboth"
# Commands that don't need to get recorded
# export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
# Save multi-line commands to the history as one command
shopt -s cmdhist
# Append to the history file, don't overwrite it
shopt -s histappend
# Set history size to a very large number
HISTSIZE=500000
HISTFILESIZE=400000
# Record each line of history right away
# instead of at the end of the session
[[ ! $PROMPT_COMMAND =~ "history -a" ]] && PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"
# Set history timestamp format
# HISTTIMEFORMAT='%F %T '