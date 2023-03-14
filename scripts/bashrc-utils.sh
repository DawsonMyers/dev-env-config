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
            string | * )
                $add_label && echo "$name: $var" || echo "$var"
                ;;
            * ) echo "type of '$name' is unknown/none" ;;
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
