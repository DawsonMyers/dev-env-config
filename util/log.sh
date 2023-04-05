# All consts are prefixed with 'dec/DEC' to identify them as belonging to the Dev-Env-Config repo.
# Regex to find color control codes: (\\\[)?(\\e|\\033)\[(\d+;)*\d+m
# regex to add prefix to consts: (^[^D# }{]) and replace with DEC_$1

DEC_CHECK_MARK="\033[0;32m\xE2\x9C\x94\033[0m"
DEC_EMOJI_CHECK_MARK=✔️
DEC_EMOJI_CHECK_MARK_GREEN='\033[0;32m✔\033[0m'
# EMOJI_CHECK_MARK=\[\033[0;32m\]✔\[\033[0m\]  escaped for a prompt
DEC_EMOJI_RED_X=❌
DEC_EMOJI_RED_X_SMALL=✘
DEC_EMOJI_RED_X_SMALL_RED='\033[0;31m✘\033[0m'
# EMOJI_RED_X_SMALL_RED='\[\033[0;31m\]✘\[\033[0m\]'
DEC_EMOJI_BULLET='•'

# Reset
DEC_Off='\033[0m'       # Text Reset

# 256 colors (only supported by vte terminals)

for i in {1..256}; do
    eval "DEC_VTE_COLOR_${i}=\"\e[38;5;${i}m\""
done

dec_display_vte_colors() {
    for i in {1..256}; do
        printf '%-5s' "$(echo -en "\e[38;5;${i}m ${i} ")"
        (( i % 8 == 0 )) && echo
    done
}

# Regular Colors
DEC_Black='\033[0;30m'        # Black
DEC_Red='\033[0;31m'          # Red
DEC_Green='\033[0;32m'        # Green
DEC_Yellow='\033[0;33m'       # Yellow
DEC_Blue='\033[0;34m'         # Blue
DEC_Purple='\033[0;35m'       # Purple
DEC_Cyan='\033[0;36m'         # Cyan
DEC_White='\033[0;37m'        # White

# Bold
DEC_BBlack='\033[1;30m'       # Black
DEC_BRed='\033[1;31m'         # Red
DEC_BGreen='\033[1;32m'       # Green
DEC_BYellow='\033[1;33m'      # Yellow
DEC_BBlue='\033[1;34m'        # Blue
DEC_BPurple='\033[1;35m'      # Purple
DEC_BCyan='\033[1;36m'        # Cyan
DEC_BWhite='\033[1;37m'       # White

# Underline
DEC_UBlack='\033[4;30m'       # Black
DEC_URed='\033[4;31m'         # Red
DEC_UGreen='\033[4;32m'       # Green
DEC_UYellow='\033[4;33m'      # Yellow
DEC_UBlue='\033[4;34m'        # Blue
DEC_UPurple='\033[4;35m'      # Purple
DEC_UCyan='\033[4;36m'        # Cyan
DEC_UWhite='\033[4;37m'       # White

# Background
DEC_On_Black='\033[40m'       # Black
DEC_On_Red='\033[41m'         # Red
DEC_On_Green='\033[42m'       # Green
DEC_On_Yellow='\033[43m'      # Yellow
DEC_On_Blue='\033[44m'        # Blue
DEC_On_Purple='\033[45m'      # Purple
DEC_On_Cyan='\033[46m'        # Cyan
DEC_On_White='\033[47m'       # White

# High Intensity
DEC_IBlack='\033[0;90m'       # Black
DEC_IRed='\033[0;91m'         # Red
DEC_IGreen='\033[0;92m'       # Green
DEC_IYellow='\033[0;93m'      # Yellow
DEC_IBlue='\033[0;94m'        # Blue
DEC_IPurple='\033[0;95m'      # Purple
DEC_ICyan='\033[0;96m'        # Cyan
DEC_IWhite='\033[0;97m'       # White

# Bold High Intensity
DEC_BIBlack='\033[1;90m'      # Black
DEC_BIRed='\033[1;91m'        # Red
DEC_BIGreen='\033[1;92m'      # Green
DEC_BIYellow='\033[1;93m'     # Yellow
DEC_BIBlue='\033[1;94m'       # Blue
DEC_BIPurple='\033[1;95m'     # Purple
DEC_BICyan='\033[1;96m'       # Cyan
DEC_BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
DEC_On_IBlack='\033[0;100m'   # Black
DEC_On_IRed='\033[0;101m'     # Red
DEC_On_IGreen='\033[0;102m'   # Green
DEC_On_IYellow='\033[0;103m'  # Yellow
DEC_On_IBlue='\033[0;104m'    # Blue
DEC_On_IPurple='\033[0;105m'  # Purple
DEC_On_ICyan='\033[0;106m'    # Cyan
DEC_On_IWhite='\033[0;107m'   # White

# Format functions
DEC_BOLD_ON="\e[1m"
DEC_BOLD_OFF="\e[21m"
DEC_DIM_ON="\e[2m"
DEC_DIM_OFF="\e[22m"
DEC_ITALIC_ON="\e[3m"
DEC_ITALIC_OFF="\e[23m"
DEC_UNDERLINE_ON="\e[4m"
DEC_UNDERLINE_OFF="\e[24m"
DEC_BLINK_ON="\e[5m"
DEC_BLINK_OFF="\e[25m"
DEC_INVERT_ON="\e[7m"
DEC_INVERT_OFF="\e[27m"
DEC_HIDE_ON="\e[8m"
DEC_HIDE_OFF="\e[28m"

dec_txt_bold() {
    echo -en "\e[1m$@\e[21m"
}

# Dim/light text.
dec_txt_dim() {
    echo -en "\e[2m$@\e[22m"
}

dec_txt_italic() {
    echo -en "\e[3m$@\e[23m"
}

dec_txt_underline() {
    echo -en "\e[4m$@\e[24m"
}

# Blinking text.
dec_txt_blink() {
    echo -en "\e[5m$@\e[25m"
}

# Inverts foreground/background text color.
dec_txt_invert() {
    echo -en "\e[7m$@\e[27m"
}

# Hides the text.
dec_txt_hide() {
    echo -en "\e[8m$@\e[28m"
}

dec_red() { echo -e "${DEC_Red}$*${DEC_Off}"; }
dec_blue() { echo -e "${DEC_Blue}$*${DEC_Off}"; }
dec_green() { echo -e "${DEC_Green}$*${DEC_Off}"; }
dec_yellow() { echo -e "${DEC_Yellow}$*${DEC_Off}"; }
dec_purple() { echo -e "${DEC_Purple}$*${DEC_Off}"; }
dec_cyan() { echo -e "${DEC_Cyan}$*${DEC_Off}"; }
dec_white() { echo -e "${DEC_White}$*${DEC_Off}"; }
dec_black() { echo -e "${DEC_Black}$*${DEC_Off}"; }