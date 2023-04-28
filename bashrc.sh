#!/bin/bash

err_was_set=
# export disable_debug_log_cmd='[[ $- =~ x ]] && debug_log_was_enabled=true && set +x'
# export restore_debug_log_state_cmd='$disable_debug_log && set +x && debug_log_was_enabled='

# disable_debug_log() { echo '[[ $- =~ x ]] && debug_log_was_enabled=true && set +x'; }
# # disable_debug_log() { echo "$disable_debug_log_cmd"; }
# restore_debug_log_state() { echo "$restore_debug_log_state_cmd"; }
# export -f disable_debug_log
# export -f restore_debug_log_state

set -eE
# set -x
dev_err_handler() {
    local lineno="$1"
    local cmd="$2"
    [[ ${BASH_SOURCE[*]} =~ git-prompt|bash-complete ]] && return
    # local line="$1" file="$2" cmd="$3"
    # echo "${BASH_COMMAND[@]}"
    # echo "${BASH_LINENO[@]}"
    R=$Red B=$Blue C=$Cyan G=$Green Y=$Yellow
    echo -e "${R}ERROR: at ${B}${BASH_SOURCE[1]//$HOME/\~}:${G}${BASH_LINENO[1]}/$lineno${Y}::${FUNCNAME[1]:-main}() ${G}with cmd: ${C}${cmd}"
    # echo "ERROR: at $line:$file with cmd: $cmd"
    for ((i=2; i < ${#BASH_SOURCE[@]}; i++)); do
        echo "       at ${BASH_SOURCE[i]}:${BASH_LINENO[i]}/$lineno in ${FUNCNAME[i]:-main}() with cmd: ${BASH_COMMAND[i]} "
    done
    # set +e

    # trap - ERR
}
# Uncomment to enable error logging.
# trap 'dev_err_handler $LINENO "$BASH_COMMAND"' ERR

# trap 'set +ex' RETURN
# trap 'dev_err_handler "$BASH_SOURCE" "$BASH_LINENO:$LINENO" "$BASH_COMMAND"' ERR
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
    set +e
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

set +xe