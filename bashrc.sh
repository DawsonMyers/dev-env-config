
# export DEV_CONFIG_DIR="$HOME/dev-env-config"
export DEV_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export MYG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)/Development"

# Shource this file in .bashrc
. $DEV_CONFIG_DIR/aliases.sh
. $DEV_CONFIG_DIR/scripts/bashrc-utils.sh



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
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTCONTROL=$HISTCONTROL:ignoredups

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