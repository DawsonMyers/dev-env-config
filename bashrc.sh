
export DEV_CONFIG_DIR="$HOME/dev-env-config"

# Shource this file in .bashrc
. $DEV_CONFIG_DIR/aliases.sh
. $DEV_CONFIG_DIR/scripts/bashrc-utils.sh


# Bash prompt
# Have to run install.sh first
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# Set default shell prompt. This is just the standard Ubuntu prompt, but with the $ starting on the next line and colourd red.
# The only difference is that the '\$' suffix is replaced with '\n\e[0;31m\$\e[m' to add a new line and colour.
# Comment to reset to normal.
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\e[0;31m\$\e[m '
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\[\e[0;31m\]\$ \[\e[m\]'
# This is the standard prompt
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '