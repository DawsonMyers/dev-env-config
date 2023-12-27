parse-opts() {
    local -A opts
    local case_sep='
        '
    local indent1='    '
    local indent2='        '
    local indent3='            '
    local case_indent='            '
    local lines=()
    local nl=$'\n'
    local code='while [[ $1 =~ ^- ]]; do
        case "$1" in
'
    for opt in "$@"; do
        local pat=${opt% *}
        local var_name=${opt#* }
        # echo "$var_name"
        local line="${case_indent}$pat ) "
        [[ $var_name =~ ^@ ]] && line+="${var_name:1}="'"$2"'" && shift ;;${nl}" ||  line+="$var_name=true ;;${nl}"
        lines+=("$line")
        code+="$line"
    done
    code+="${indent2}esac;${nl}"
    code+="${indent2}shift;${nl}"
    code+="${indent1}done${nl}"
    # code+="${indent1}shift \$((OPTIND - 1))${nl}"
    
    # echo "CODE: ${code[*]}"
#     echo "eval <<<EOS
#     ${code[@]}
# EOS
# "
    echo "eval ${code[*]}"
    

}
# src='./parse-opts.sh "-f|--file @file" "-s|--silent silent"'
# ./parse-opts.sh "-f|--file @file" "-s|--silent silent"



atest() {
    while [[ $1 =~ ^-+ ]]; do
        case "$1" in
            -f|--file ) file="$2" && shift ;;
            -s|--silent ) silent=true ;;
        esac
        shift
    done
    e file silent
}

parsetest() {
    parse-opts "-f|--file @file" "-s|--silent silent"
    $(parse-opts "-f|--file @file" "-s|--silent silent")

    # while [[ $1 =~ ^-+ ]]; do
    #     case "$1" in
    #         -f|--file ) file="$2" && shift ;;
    #         -s|--silent ) silent=true ;;
    #     esac
    #     shift
    # done
    echo file:$file -- silent:$silent
}


(( ${#} != 0 )) && parsetest "$@"
# (( ${#} != 0 )) && parse-opts "$@"





# parse-opts() {
#     local -A opts
#     local case_sep='
#         '
#     local indent1='    '
#     local indent2='        '
#     local indent3='            '
#     local case_indent='            '
#     local lines=()
#     local nl=$'\n'
#     local code='    local OPTIND
#     while [[ $1 =~ -+ ]]
#         do
#         case "$1 in
# '
#     for opt in "$@"; do
#         local pat=${opt% *}
#         local var_name=${opt#* }
#         # echo "$var_name"
#         local line="${case_indent}$pat ) "
#         [[ $var_name =~ ^@ ]] && line+="${var_name:1}="'"$OPTARG"'" ;;${nl}" ||  line+="$var_name=true ;;${nl}"
#         lines+=("$line")
#         code+="$line"
#     done
#     code+="${indent2}esac${nl}"
#     code+="${indent1}done${nl}"
#     code+="${indent1}shift \$((OPTIND - 1))${nl}"
    
#     # echo "CODE: ${code[*]}"
# #     echo "eval <<<'EOS'
# #     ${code[*]}
# # EOS
# # "
#     echo "eval ${code[*]}"
    

# }
# # src='./parse-opts.sh "-f|--file @file" "-s|--silent silent"'
# # ./parse-opts.sh "-f|--file @file" "-s|--silent silent"
# (( ${#} != 0 )) && parse-opts "$@"