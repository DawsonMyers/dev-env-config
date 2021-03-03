# Convert jira issue name into git branch name.
# MYG-14784 Create Backend for Device Sharing => MYG-14784-create-backend-for-device-sharing
mkbranch() {
    jira_name="$@"
    local n=`echo "${jira_name:3}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed -e 's/-\+/-/g'`
    echo "MYG${n}"
    # copy to clipboard
    echo -n "MYG${n}" | xclip -selection c
}
alias mkbrc=mkbranch

# Don't convert to lower case
mkbranchc() {
    jira_name="$@"
    local n=`echo "${jira_name:3}" | tr ' ' '-' | sed -e 's/-\+/-/g'`
    echo "MYG${n}"
    # copy to clipboard
    echo -n "MYG${n}" | xclip -selection c
}
alias mkbrcc=mkbranchc

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
    cd /home/dawsonmyers/repos/killbear-booker
    local proj=`proj_id $1`
    gcloud app deploy --project=$proj --stop-previous-version && gcloud app logs tail -s default --project=$proj
}

# Killbear log
kbl() { # arg: projId
    cd /home/dawsonmyers/repos/killbear-booker
    local proj=`proj_id $1`
    gcloud app logs tail -s default --project=$proj
}

# Killbear stop
kbs() { # args: (projId, version)
    cd /home/dawsonmyers/repos/killbear-booker
    local proj=`proj_id $1`
    gcloud app versions stop --project=$proj $2
}

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
#     pushd ~/repos/MyGeotab
#     run_analyzer StyleCop.Analyzers $MYG_CORE_PROJ
#     run_analyzer Roslynator.Analyzers $MYG_TEST_PROJ
#     popd
# }

# run_analyzer() {
#     ANALYZER_NAME=$1
#     ANALYZER_PROJ=$2
#     dotnet build -p:DebugAnalyzers=${ANALYZER_NAME} -p:TreatWarningsAsErrors=false ${ANALYZER_PROJ} | tee analyzerOutput.txt
# }

