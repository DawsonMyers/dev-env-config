
# export DEV_CONFIG_DIR="$HOME/dev-env-config"
export DEV_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export MYG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)/Development"

# Shource this file in .bashrc
. $DEV_CONFIG_DIR/aliases.sh
. $DEV_CONFIG_DIR/scripts/bashrc-utils.sh


# Bash prompt
# Have to run install.sh first
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

running_geo_cli_container() {
    name=$(docker ps --format '{{ .Names }}')
    name=${name##geo_cli_db_postgres_}
    [[ -n $name ]] && echo "[$name]"
}

. $DEV_CONFIG_DIR/prompt.sh

# Set default shell prompt. This is just the standard Ubuntu prompt, but with the $ starting on the next line and colourd red.
# The only difference is that the '\$' suffix is replaced with '\n\e[0;31m\$\e[m' to add a new line and colour.
# Comment to reset to normal.
# PS1='\[\033[01;32m\]\u@\h\[\033[00m\]$(running_geo_cli_container):\[\033[01;34m\]\w\[\033[00m\]\n\[\e[0;31m\]\$ \[\e[m\]'

# Define a few Colours
# BLACK='\[\e[0;30m\]'
# BLUE='\[\e[0;34m\]'
# GREEN='\[\e[0;32m\]'
# CYAN='\[\e[0;36m\]'
# RED='\[\e[0;31m\]'

# BBLUE="\[\033[1;34m\]"

# PURPLE='\[\e[0;35m\]'
# BROWN='\[\e[0;33m\]'
# LIGHTGRAY='\[\e[0;37m\]'
# DARKGRAY='\[\e[1;30m\]'
# LIGHTBLUE='\[\e[1;34m\]'
# LIGHTGREEN='\[\e[1;32m\]'
# LIGHTCYAN='\[\e[1;36m\]'
# LIGHTRED='\[\e[1;31m\]'
# LIGHTPURPLE='\[\e[1;35m\]'
# YELLOW='\[\e[1;33m\]'
# WHITE='\[\e[1;37m\]'
# NC='\[\e[0m\]' # No Color
# old
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h${NC}:${BBLUE}\w${NC}\n${RED}\$${NC} '
# This is the standard prompt
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# https://docstore.mik.ua/orelly/unix3/upt/ch31_05.htm
[[ -d ~/Code ]] && CDPATH=:~/Code
[[ -d ~/repos ]] && CDPATH=:~/repos

# Allows for typing the start of a command, for example gcloud then using the up and down arrows to cycle through your history for matching commands
# bind '"\e[A": history-search-backward'
# bind '"\e[B": history-search-forward'

# Add GitLab PAT environment variables.
[[ -f $DEV_CONFIG_DIR/include/gitlab/gitlab-pat ]] && . $DEV_CONFIG_DIR/include/gitlab/gitlab-pat

gcor() {
    (
        geo cd dev
        git checkout release/$1.0
    )
}