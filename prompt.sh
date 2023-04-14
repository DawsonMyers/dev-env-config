#!/bin/bash
# Colours for prompts have to be inside of \[COLOR\] escape sequences or the prompt line with overwrite itself.
#----------------------------------------------------------------------------#
# Bash text colour specification:  \e[<STYLE>;<COLOUR>m
# (Note: \e = \033 (oct) = \x1b (hex) = 27 (dec) = "Escape")
# Styles:  0=normal, 1=bold, 2=dimmed, 4=underlined, 7=highlighted
# Colours: 31=red, 32=green, 33=yellow, 34=blue, 35=purple, 36=cyan, 37=white
#----------------------------------------------------------------------------#

# All colours are prefixed with 'P' to identify them as prompt colours. They will print '\[' when logged to the console
# without being in a PS1-4 prompt. For normal prompt colouring, don't wrap in \[ \]
# Reset
PPColor_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
PBlack="\[\033[0;30m\]"        # Black
PRed="\[\033[0;31m\]"          # Red
PGreen="\[\033[0;32m\]"        # Green
PYellow="\[\033[0;33m\]"       # Yellow
PBlue="\[\033[0;34m\]"         # Blue
PPurple="\[\033[0;35m\]"       # Purple
PCyan="\[\033[0;36m\]"         # Cyan
PWhite="\[\033[0;37m\]"        # WhiteRed

# Bold
PBBlack="\[\033[1;30m\]"       # Black
PBRed="\[\033[1;31m\]"         # Red
PBGreen="\[\033[1;32m\]"       # Green
PBYellow="\[\033[1;33m\]"      # Yellow
PBBlue="\[\033[1;34m\]"        # Blue
PBPurple="\[\033[1;35m\]"      # Purple
PBCyan="\[\033[1;36m\]"        # Cyan
PBWhite="\[\033[1;37m\]"       # White

# Underline
PUBlack="\[\033[4;30m\]"       # Black
PURed="\[\033[4;31m\]"         # Red
PUGreen="\[\033[4;32m\]"       # Green
PUYellow="\[\033[4;33m\]"      # Yellow
PUBlue="\[\033[4;34m\]"        # Blue
PUPurple="\[\033[4;35m\]"      # Purple
PUCyan="\[\033[4;36m\]"        # Cyan
PUWhite="\[\033[4;37m\]"       # White

# Background
POn_Black="\[\033[40m\]"       # Black
POn_Red="\[\033[41m\]"         # Red
POn_Green="\[\033[42m\]"       # Green
POn_Yellow="\[\033[43m\]"      # Yellow
POn_Blue="\[\033[44m\]"        # Blue
POn_Purple="\[\033[45m\]"      # Purple
POn_Cyan="\[\033[46m\]"        # Cyan
POn_White="\[\033[47m\]"       # White

# High Intensty
PIBlack="\[\033[0;90m\]"       # Black
PIRed="\[\033[0;91m\]"         # Red
PIGreen="\[\033[0;92m\]"       # Green
PIYellow="\[\033[0;93m\]"      # Yellow
PIBlue="\[\033[0;94m\]"        # Blue
PIPurple="\[\033[0;95m\]"      # Purple
PICyan="\[\033[0;96m\]"        # Cyan
PIWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
PBIBlack="\[\033[1;90m\]"      # Black
PBIRed="\[\033[1;91m\]"        # Red
PBIGreen="\[\033[1;92m\]"      # Green
PBIYellow="\[\033[1;93m\]"     # Yellow
PBIBlue="\[\033[1;94m\]"       # Blue
PBIPurple="\[\033[1;95m\]"     # Purple
PBICyan="\[\033[1;96m\]"       # Cyan
PBIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
POn_IBlack="\[\033[0;100m\]"   # Black
POn_IRed="\[\033[0;101m\]"     # Red
POn_IGreen="\[\033[0;102m\]"   # Green
POn_IYellow="\[\033[0;103m\]"  # Yellow
POn_IBlue="\[\033[0;104m\]"    # Blue
POn_IPurple="\[\033[10;95m\]"  # Purple
POn_ICyan="\[\033[0;106m\]"    # Cyan
POn_IWhite="\[\033[0;107m\]"   # White

# There are several variables that can be set to control the appearance of the bach command prompt: PS1, PS2, PS3, PS4 and PROMPT_COMMAND the contents are executed just as if they had been typed on the command line.

# PS1 – Default interactive prompt (this is the variable most often customized)
# PS2 – Continuation interactive prompt (when a long command is broken up with \ at the end of the line) default=">"
# PS3 – Prompt used by “select” loop inside a shell script
# PS4 – Prompt used when a shell script is executed in debug mode (“set -x” will turn this on) default ="++"
# PROMPT_COMMAND - If this variable is set and has a non-null value, then it will be executed just before the PS1 variable.

# \d   The date, in "Weekday Month Date" format (e.g., "Tue May 26"). 
# \h   The hostname, up to the first . (e.g. deckard) 
# \H   The hostname. (e.g. deckard.SS64.com)
# \j   The number of jobs currently managed by the shell. 
# \l   The basename of the shell's terminal device name. 
# \s   The name of the shell, the basename of $0 (the portion following the final slash). 
# \t   The time, in 24-hour HH:MM:SS format. 
# \T   The time, in 12-hour HH:MM:SS format. 
# \@   The time, in 12-hour am/pm format. 
# \u   The username of the current user. 
# \v   The version of Bash (e.g., 2.00) 
# \V   The release of Bash, version + patchlevel (e.g., 2.00.0) 
# \w   The current working directory. 
# \W   The basename of $PWD. 
# \!   The history number of this command. 
# \#   The command number of this command. 
# \$   If you are not root, inserts a "$"; if you are root, you get a "#"  (root uid = 0) 
# \nnn   The character whose ASCII code is the octal value nnn. 
# \n   A newline. 
# \r   A carriage return. 
# \e   An escape character (typically a color code). 
# \a   A bell character.
# \\   A backslash. 
# \[   Begin a sequence of non-printing characters. (like color escape sequences). This
#     allows bash to calculate word wrapping correctly.
# \]   End a sequence of non-printing characters.

# Using single quotes instead of double quotes when exporting your PS variables is recommended, it makes the prompt a tiny bit faster to evaluate.
# Various variables you might want for your PS1 prompt instead

Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"
User='\u'
Host='\h'

PROMPT_COMMAND_OK="${PGreen}✔${Color_Off}"    # indicator if the last command returned with an exit code of 0
PROMPT_COMMAND_FAIL="${PRed}✘${Color_Off}"    # indicator if the last command returned with an exit code of other than 0

# PROMPT_COMMAND=__prompt_command    # Function to generate PS1 after CMDs



# This command runs after each terminal command execution to recreate the prompt.
__prompt_command() {
    [[ $- != *i* ]] && return
    export MYG_RELEASE=$(cd ~/repos/Development && git describe --tags --abbrev=0 --match MYG* | sed -e 's_MYG/__g')
    # export MYG_RELEASE=$(geo  --raw-output dev release)
    [[ -n $MYG_RELEASE ]] && export MYG_RELEASE_TAG="($MYG_RELEASE)" || MYG_RELEASE_TAG=
    # echo "__prompt_command RET = $GIT_PROMPT_LAST_COMMAND_STATE"
    if [[ $(we_are_on_repo) == 1 ]]; then
        # local release
        # # PS1='\[\033[0;32m\]✔\[\033[0;0m\] \[\033[0;33m\]\w\[\033[0;0m\] [\[\033[0;35m\]${GIT_BRANCH}\[\033[0;0m\]|\[\033[0;34m\]✚ 1\[\033[0;0m\]\[\033[1;34m\]⚑ 9\[\033[0;0m\]\[\033[0;0m\]] \n\[\033[0;37m\]$(date +%H:%M)\[\033(8.0) 0;0m\] $'
        # local start='\[\033[0;32m\]✔\[\033[0;0m\]'
        # local end='\[\033[0;33m\]\w\[\033[0;0m\] [\[\033[0;35m\]${GIT_BRANCH}\[\033[0;0m\]|\[\033[0;34m\]✚ 1\[\033[0;0m\]\[\033[1;34m\]⚑ 9\[\033[0;0m\]\[\033[0;0m\]] \n\[\033[0;37m\]$(date +%H:%M)\[\033(8.0) 0;0m\] $'
        # PS1="$start $MYG_RELEASE_TAG $end"
        # local start="${PS1%%* }"
        # local end="${PS1#* }"
        # $dev_on_myg_repo && PS1+=
        # PS1="$( PS1=$PS1; echo $PS1  | sed -E "s/(.*)\\n/\1$MYG_RELEASE_TAG\\n/")"
        return    
    fi

#     ✔ ~/ [MYG] 
# 03:23(8.0)

# good: \[\033[0;32m\]✔\[\033[0m\] \033[1;32m\u\[\033[0m\]\033[0;35m(Mon Mar 27 02:05:11 PM):\033[1;34m\w\[\033[0m\]\033[0;31m\n$\[\033[0m\]
# bad : \033[0;31m✘ \[\033[1;32m\]\u\[\033[0;35m\](Mon Mar 27 07:13:07 PM):\[\033[1;34m\]\w\[\033[0;31m\]\n$
    local status=
    [[ $GIT_PROMPT_LAST_COMMAND_STATE == 0 ]] && status=$PROMPT_COMMAND_OK || status=$PROMPT_COMMAND_FAIL
    PS1="$status ${debian_chroot:+($debian_chroot)}"
    local relative_path=$(pwd)
    relative_path="${relative_path//$HOME/~}"

    # The \n must be in between the color on and color off characters, otherwise it will overwrite the line.
    PS1+="${PBGreen}${User}${Color_Off}${PPurple}($(ps1_timestamp)):${PBBlue}$(export prev_bcmd="$BASH_COMMAND";set_terminal_title -d "${PathShort}")[$-] ${PathShort}${Color_Off}${VTE_COLOR_27}\n\$\[${VTE_COLOR_37}\] "
    
    # PS1+="${PBGreen}${User}${Color_Off}${PPurple}($(ps1_timestamp)):${PBBlue}$(export prev_bcmd="$BASH_COMMAND";set_terminal_title -d "${PathShort}")${PathShort}${Color_Off}${PCYAN}\n\$\[${VTE_COLOR_214}\] "
    # PS1+="${PBGreen}${User}${Color_Off}${PPurple}($(ps1_timestamp)):${PBBlue}$(export prev_bcmd="$BASH_COMMAND";set_terminal_title -d "${PathShort}")${PathShort}${Color_Off}${PRed}\n\$${Color_Off} "
    # PS1+="${PBGreen}${User}${Color_Off}${Purple}($(ps1_timestamp))\@:${BBlue}$(export prev_bcmd="$BASH_COMMAND";set_terminal_title -d "${PathShort}")${PathShort}${Color_Off}${Red}\n\$${Color_Off} "
    # PS1+="${PBGreen}${User}${Color_Off}${Purple}($(ps1_timestamp)):${BBlue}\$(set_terminal_title -d "$BASH_COMMAND|$PathShort")${PathShort}${Color_Off}${Red}\n\$${Color_Off} "
    # PS1+="${PBGreen}${User}${Color_Off}${Purple}($(ps1_timestamp)):${BBlue}\$(set_terminal_title -d ${PathShort})${Color_Off}${Red}\n\$${Color_Off} "
    # PS1+="${PBGreen}${User}${Color_Off}${Purple}($(ps1_timestamp)):${BBlue}\$(_set_title_only ${PathShort})${Color_Off}${Red}\n\$${Color_Off} "
    # PS1+="${PBGreen}${User}${Color_Off}${Purple}($(ps1_timestamp)):${BBlue}${PathShort}${Color_Off}${Red}\n\$${Color_Off} "
    # _set_title_only "$PathShort"
    # PS1+="${Purple}[$(ps1_timestamp)]${PBGreen}${User}${Color_Off}:${BBlue}${PathShort}${Color_Off}${Red}\n\$${Color_Off} "
}
# export LAST_BASH_CMD
# [[ -n $PS0 || ! $PS0 == *LAST_BASH_CMD* ]] && PS0+='eval cmd="$BASH_COMMAND"'

update_title_with_directory() {
    'echo -ne "\033]0;$(basename ${PWD})\007"'
}

ps1_timestamp() {
    # Tue Mar 21 09:59:48 AM
    date '+%a %b %e %r'
    # 03/21/23 10:00:47
    # date '+%D %T'
    # date '+%d %H:%M:%S'
}

export PS2="$PCyan"
# export PS2="$On_ICyan"

# __prompt_command

# Add our prompt command after git-prompt commands.
[[ ! $PROMPT_COMMAND =~ __prompt_command ]] && PROMPT_COMMAND+=';__prompt_command'
PROMPT_COMMAND=$(sed -E 's/;+/;/g' <<<"$PROMPT_COMMAND")