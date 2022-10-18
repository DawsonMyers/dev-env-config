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

search() {
    local extension=
    [[ $1 == -e ]] && extension="--include=*.$2" $$ shift 2

    egrep -ir $extension "$1" .
}