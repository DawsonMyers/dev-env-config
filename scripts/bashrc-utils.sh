#!/bin/bash

[[ ! -v DEV_CONFIG_DIR ]] && export DEV_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Convert jira issue name into git branch name.
# MYG-14784 Create Backend for Device Sharing => MYG-14784-create-backend-for-device-sharing
mkbranch() {
    jira_name="$@"
    local n=`echo "${jira_name:3}" | tr '[:upper:]' '[:lower:]' | sed -e 's/\W\+/-/g'`
    echo "MYG${n}"
    # copy to clipboard
    echo -n "MYG${n}" | xclip -selection c
}
alias mkbrc=mkbranch

# Don't convert to lower case
mkbranchc() {
    jira_name="$@"
    local n=`echo "${jira_name:3}" | sed -e 's/\W\+/-/g'`
    echo "MYG${n}"
    # copy to clipboard
    echo -n "MYG${n}" | xclip -selection c
}
alias mkbrcc=mkbranchc

KILLBEAR_BOOKER_DIR=/home/dawsonmyers/Code/killbear-booker

# .bashrc functions
###############################################################
# Project ids (projId)  InstanceMax
# 0: 'killbear-booker' 30
# 1: 'killbear' 40
# 2: 'killbear-booker2' 40
# 3: 'kbooker3' 40
# 4: 'killbear-booker4' 8

# Killbear booker
###############################################################################
proj_id() { # arg: projId
    local proj=''
    case $1 in
    0)
        proj='killbear-booker'
        ;;
    1)
        proj='killbear'
        ;;
    2)
        proj='killbear-booker2'
        ;;
    3)
        proj='kbooker3'
        ;;
    4)
        proj='killbear-booker4'
        ;;
    esac
    echo -n $proj
}

# Killbear deploy
kbd() { # arg: projId
    (
        cd $KILLBEAR_BOOKER_DIR
        local proj=$(proj_id $1)
        gcloud app deploy --project=$proj --stop-previous-version && gcloud app logs tail -s default --project=$proj
    )

}

# Killbear log
kbl() { # arg: projId
    (
        cd $KILLBEAR_BOOKER_DIR
        local proj=$(proj_id $1)
        gcloud app logs tail -s default --project=$proj
    )

}

# Killbear stop
kbs() { # args: (projId, version)
    (
        cd $KILLBEAR_BOOKER_DIR
        local proj=$(proj_id $1)
        gcloud app versions stop --project=$proj $2
    )

}

if [[ -d $KILLBEAR_BOOKER_DIR ]]; then
    source $KILLBEAR_BOOKER_DIR/bashrc-gcp-funcs.sh
fi

# Extracting
extract () {

 if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"

 fi
}

# analyze() {
#     MYG_TEST_PROJ=Checkmate/MyGeotab.Core.Tests/MyGeotab.Core.Tests.csproj
#     MYG_CORE_PROJ=Checkmate/MyGeotab.Core.csproj
#     pushd ~/Code/MyGeotab
#     run_analyzer StyleCop.Analyzers $MYG_CORE_PROJ
#     run_analyzer Roslynator.Analyzers $MYG_TEST_PROJ
#     popd
# }

# run_analyzer() {
#     ANALYZER_NAME=$1
#     ANALYZER_PROJ=$2
#     dotnet build -p:DebugAnalyzers=${ANALYZER_NAME} -p:TreatWarningsAsErrors=false ${ANALYZER_PROJ} | tee analyzerOutput.txt
# }

#  Counts the lines of code in all files in this directory and subdirectories.
#  parameters:
#     1: the file type extension to count lines of code for (e.g., py, cs, sh, etc.)
loc() {
    local file_type=$1
    find . -name '*'$file_type | xargs wc -l
}

# Run this to fix symlinks after changing the nvm node version. This is required when running in non-interactive terminials,
# since they don't have the same path variables available.
setup-node-links() {
    # set -eEB

    if [ -L /usr/bin/node ]; then
        sudo rm -f /usr/bin/node
    fi

    if [ -L /usr/bin/npm ]; then
        sudo rm -f /usr/bin/npm
    fi

    if [ -L /usr/bin/npx ]; then
        sudo rm -f /usr/bin/npx
    fi

    sudo ln -s "$(which node)" /usr/bin/
    sudo ln -s "$(which npm)" /usr/bin/
    sudo ln -s "$(which npx)" /usr/bin/
}

geo-ui-pic() {
    # -s=X,Y,W,H
    shutter -e -d=3 -s=2270,28,288,771
    # shutter -e -d=3 -s=2200,28,288,771
}

geo-ui-pic1() {
    # -s=X,Y,W,H
    shutter -e -d=3 -s=2232,2,325,920
    # shutter -e -d=3 -s=2200,28,288,771
}

search() {
    local extension=
    [[ $1 == -e ]] && extension="--include=*.$2" $$ shift 2

    egrep -ir $extension "$1" .
}

# Hex to decimal
h2d () {
    printf '%d' $((16#$1))
}

# Decimal to hex
d2h () {
    printf '%x' $((10#$1))
}

# cd into directory, creating it first if it doesn't exist.
cdmk() {
    local path="$1"
    # local root_path="$(pwd)"
    # [[ -n $root_path ]] && $root_path="$root_path/"
    [[ ! -d $path ]] && mkdir -p "$path" && echo "Directory created at '$path'"
    cd "$path"
}

update_vs_code() {
    wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O /tmp/code_latest_amd64.deb
    sudo dpkg -i /tmp/code_latest_amd64.deb
}

update_chrome() {
    sudo apt-get update
    sudo apt-get --only-upgrade install google-chrome-stable
}

# Echo variables
evar() {
    local print_on_newline=false
    local add_label=true
    [[ $1 == -n ]] && print_on_newline=true && shift
    [[ $1 == --label ]] && add_label=true && shift
    [[ $1 == --re ]] && print_array BASH_REMATCH && return
    # echo "$# $@"x
    if (( $# > 1 )); then
        for arg in "$@"; do
            evar --label "$arg"
        done
        return
    fi

    ! is_var $1 && echo "value: '$1'"
    # ! is_var $1 && echo "'$1' is a value, not a variable"

    # echo "$# 1: $1"

    while is_var $1; do
        local name=$1
        local -n var=$1
        local vartype=$(typeof $1)
        # echo vartype $vartype
        # if [[ $vartype == array ]] && echo "${var[@]}" || echo "$var"
        case $vartype in
            array )
                local count=${#var}
                $add_label && echo "$name[$count]"
                local i=0
                for item in "${var[@]}"; do
                    $add_label && echo "  [$((i++))] = $item" || echo "$item"
                done
                ;;
            map )
                local count=${#var}
                $add_label && echo "$name{$count}"
                for key in "${!var[@]}"; do
                    $add_label && echo "  $name[$key] = ${var[$key]}" || echo "${var[$key]}"
                done
                ;;
            export )
                $add_label && echo "export $name: $var" || echo "$var"
                ;;
            string | * )
                $add_label && echo "$name: $var" || echo "$var"
                ;;
            * ) echo "type of '$name' is unknown/none. Ref attempt: \$$name = $var" ;;
        esac
        shift
    done
}

ere() {
    [[ -z $1 ]] && print_array BASH_REMATCH && return
    # local array=("${BASH_REMATCH[@]}")
    while [[ -n $1 ]]; do
        echo "BASH_REMATCH[$1] = ${BASH_REMATCH[$1]}"
        shift;
    done
    # BASH_REMATCH=("${array[@]}")
}

dev_pre_re=

re() {
    set -x
    local str="$1"
    local regex="${2:-$dev_pre_re}"
    [[ -z $str ]] && return 1
    # Reuse previous regex.
    # [[ -z $regex && -n $dev_pre_re ]] && regex="$dev_pre_re"

    log::debug "[[ $str =~ $regex ]] && ere"
    [[ $str =~ $regex ]] && ere
    dev_pre_re="$regex"
    (( 1 == 2))
    set +x
}

print_array() {
    local -n array=$1
    for item in "${array[@]}"; do
        echo "$item"
    done
}

get_var_sig() { 
    local has_var=false
    [[ $1 == -v ]] && local -n ref=$2 && has_var=true && shift 2
    local sig="$(declare -p "$1" 2>/dev/null)"
    [[ $has_var == true ]] && ref="$sig" && return
}

is_var() { 
    [[ $(typeof $1) != none ]]
}

typeof () {
    local has_var=false
    [[ $1 == -v ]] && local -n ref=$2 && has_var=true && shift 2

    local type_signature #=$(declare -p "$1" 2>/dev/null)
    local var_name=$1
    util::get_ref_var_name -v "var_name" $1
    get_var_sig -v type_signature $var_name
    # echo type_signature "$type_signature"
    # evar type_signature
    local var_type=none
    if [[ "$type_signature" =~ "declare --" ]]; then
        var_type="string"
    elif [[ "$type_signature" =~ "declare -a" ]]; then
        var_type="array"
    elif [[ "$type_signature" =~ "declare -A" ]]; then
        var_type="map"
    elif [[ "$type_signature" =~ "declare -n" ]]; then
        var_type="ref"
    elif [[ "$type_signature" =~ "declare -x" ]]; then
        var_type="export"
        # local name="${type_signature#*\"}"
        # name="${name%%=\"}"
        # # printf "name $name"
        # [[ ! $name == $1 && $name != $type_signature ]] && typeof $name
        # echo "[[ ! $name == $1 && $name != $type_signature ]] && typeof $name"
        # typeof $name
    else
        var_type="none"
    fi
    
    $has_var && ref="$var_type" && return
    echo "$var_type"
}

remove-pg-admin-password() {
    
    (
        local password_line_false='MASTER_PASSWORD_REQUIRED = False'
        local password_line_true='MASTER_PASSWORD_REQUIRED = True'
        cd /usr/pgadmin4/web || return 1
        
        [[ ! -f config_local.py ]] && sudo touch config_local.py
        ! grep "$password_line_false" config_local.py && sudo tee -a config_local.py <<<"$password_line_false"
        ! grep "$password_line_false" config.py && sudo sed -ie "s/$password_line_true/$password_line_false/g" config.py
    )
}

_geo_set_terminal_title() {
    local d="$(date '+%d %H:%M:%S')"
     local date_str=
    [[ $1 == -d ]] && date_str=" - $(date '+%d %H:%M:%S')" && shift
    echo -ne "\033]0;$* $date_str\007"
}

clip_tile_length() {
    local cmd="$@"
    if [[ ${#cmd} -gt 20 ]]; then
        echo "...${cmd: -20}"
        return
    fi
    echo "$cmd"
}
# shellcheck disable=SC2120
set_terminal_title() {
    [[ ! $prev_bcmd =~ "source ~/.bashrc" || $prev_bcmd =~ =\"+(.+)\" ]] \
        && cmd="${BASH_REMATCH[1]} " \
        && cmd="$(clip_tile_length "$cmd")"
        # && cmd="${cmd#export prev_bcmd=\"}" \
    # cmd="$prev_bcmd"; # = $BASH_COMMAND

    # cmd="${cmd:0: -1}"
    # local d="$(date '+%d %H:%M:%S')"
    #  local date_str=
     local title=""
    local date_str=
    local arg_title=
    # local geo_arg=
    local OPTIND
            while getopts "dgt:" opt; do
                case "${opt}" in
                    d ) date_str="$(date '+%a %b %e %r')"  ;;
                    # d ) date_str="$(date '+%d %H:%M:%S')"  ;;
                    g ) geo_title="[ geo-cli ]" ;;
                    t ) arg_title="$OPTARG" ;;
                    
                esac
            done
            shift $((OPTIND - 1))

     local title="$*"
     : ${title:="$MYG_RELEASE_TAG"}
     title="${title//$HOME/\~}"
    #  [[ -n $arg_title ]] && title="$arg_title"
    #  [[ $# -gt 0 ]] && title+=" | $*"
    [[ -n $cmd ]] && title+=" $cmd" 

    [[ -n $date_str ]] && title="[$date_str] | $title"
# red $MYG_RELEASE
    [[ -n $MYG_RELEASE_TAG ]] && title=" $MYG_RELEASE | $title"
    #  [[ -n $date_str ]] && title="$title | ($date_str)"
    
    # echo c="$cmd" 
    # echo "n=\${#cmd} = $c"
    # n=${#cmd}
    # inc=$((n>20 ? 20 : n))
    # echo "inc=\$\(\($n>20 ? 20 : $n\)\) = $inc"
    # i=$((n - inc))
    # echo "i=\$(($n - $inc))"
    # cmd="${cmd:$inc}"; 
    # echo "cmd="\$cmd:$inc"; = $cmd"

    # echo -ne "\033]0;$cmd${title}\007"
    echo -ne "\033]0;${title}\007"
    # echo -ne "\033]0;${title}${msg}\007"
}
# set_terminal_title

_set_title_only() {
    local title="$*"
    [[ $1 == -e ]] && shift && title="$*" &&  echo "$*"
    echo -ne "\033]0;${title}\007"
}

dev_get_repo_name() {
    basename $(git rev-parse --show-toplevel) 2> /dev/null
}

dev_on_myg_repo() {
    local repo=$(dev_get_repo_name)
    [[ $repo == Development ]]
}

# export MYG_RELEASE=$(geo dev release) 2> /dev/null
# export MYG_RELEASE_TAG="($(geo --raw-output dev release))" 2> /dev/null

# _geo__set_terminal_title() {
#     # local d="$(date '+%d %H:%M:%S')"
#     #  local date_str=
#      local title=""
#     local date_str=
#     local geo_title=
#     # local geo_arg=
#     local OPTIND
#             while getopts "dgG:" opt; do
#                 case "${opt}" in
#                     d ) date_str="$(date '+%d %H:%M:%S')"  ;;
#                     g ) geo_title="[ geo-cli ]" ;;
#                     G ) geo_title="[ geo $OPTARG ]" ;;
                    
#                 esac
#             done
#             shift $((OPTIND - 1))

#      local title=
#      [[ -n $geo_title ]] && title="$geo_title"
#      [[ $# -gt 0 ]] && title+=" - $*"
#      [[ -n $date_str ]] && title="$title - $date_str"
#     echo -ne "\033]0;${title}${msg}\007"
# }

# Echo on new lines. Echos out args on their own line.
enl() {
    for arg in "$@"; do echo "$arg"; done
}

file_size() {
    stat -c '%s' "$1"
}

command_not_found_handle () 
{ 
    if [ -x /usr/lib/command-not-found ]; then
        /usr/lib/command-not-found -- "$1";
        return $?;
    else
        if [ -x /usr/share/command-not-found/command-not-found ]; then
            /usr/share/command-not-found/command-not-found -- "$1";
            return $?;
        else
            printf "%s: command not found\n" "$1" 1>&2;
            return 127;
        fi;
    fi
}

get_stacktrace() {
    local full_stack=true relative=true
    [[ $1 =~ ^-*f* ]] && full_stack=true
    [[ $1 =~ ^-*R* ]] && relative=false
    local stack_size=${#BASH_SOURCE[@]}
    # Start at 1 (not 0) to  exclude this func from the path.
    local start=1
    e stack_size
    if $full_stack; then
        for ((i=start; i < stack_size; i++)) ; do
            local source_file="${BASH_SOURCE[i]:-terminal}"
            local func="${FUNCNAME[i]:-command_line}"
            local lineno=${BASH_LINENO[i]}
            local stack_line='empty trace line'
            [[ -z $lineno ]] && stack_line="↪ at $func in $source_file" \
                || stack_line="↪ at $func in $source_file:$lineno"
            # line=
            [[ -n $make_path_relative_option ]] && stack_line="$(log::make_path_relative_to_user_dir "$stack_line")"
            log::debug "$stack_line"
        done
        return
    fi
    # debug "_stacktrace: ${FUNCNAME[@]}"
    local stacktrace="${FUNCNAME[@]:start}"
    local stacktrace_reversed=
    for f in $stacktrace; do
        [[ -z $stacktrace_reversed ]] && stacktrace_reversed=$f && continue
        stacktrace_reversed="$f.$stacktrace_reversed"
        # stacktrace_reversed="$f -> $stacktrace_reversed"
    done
}

dec_red() { echo -e "${DEC_Red}${*}${DEC_Off}"; }


function ccat()
{
    local opts='-g'
    [[ $1 =~ -l|-L|--line.* ]] \
        && opts+=" -O style=colorful,linenos=1" \
        && shift 2

    pygmentize $opts "$*"
}


install_font() {
    local installer="$DEV_CONFIG_DIR/submodules/nerd-fonts/install.sh"
	if [[ -f $installer ]]; then
		$installer $*
	else
		echo "ERROR: Nerd font installer not found at: $installer" 
	fi
}