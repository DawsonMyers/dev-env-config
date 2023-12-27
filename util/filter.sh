#!/bin/bash

# usage:
#  * find lines that include error or exception
#       cat logs.txt | filter "error|exception"
#  * exclude lines that include error or exception
#       cat logs.txt | filter --invert "error|exception"
#       cat logs.txt | filter --invert "error|exception"
#  Or run the file directly:
#       cat logs.txt | ./filter.sh "error|exception"
filter() {
    local invert=false
    [[ $1 =~ -i|-v|--invert ]] && invert=true && shift
    pattern="$1" 
    IFS=$' '
    # IFS=$'\n'
    while read -r line; do
        if grep -E "$pattern" <<<"$line" &>/dev/null; then
            $invert && continue
            echo "$line"
        else
            $invert && echo "$line"
        fi
        
    done
}

[[ -n $1 ]] && filter "$@"
