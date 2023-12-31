#!/bin/bash

# Set your editor of choice below. If not set, the EDITOR environment
# variable is used.
# EDITOR=emacs

# Create temp file and set script name
temp_file=$(mktemp GIT_APPLY_PATCH_TO_FILE.XXXXX)
name=${0##*/}

# Default values
target_file=""
use_editor=1

# Clean up if script is interrupted or terminated.
trap "cleanup" SIGINT SIGTERM 1 0

# To support a list that's not delimited by spaces, we need to change IFS
# Back it up so we can restore it later
oldIFS=$IFS
IFS=$'\n'

function return_error {

    local error_msg=${1-"Unexpected error"}
    local exit_code=${2-1}

    printf "%s\n" "$name: $error_msg" >&2
    cleanup
    exit $exit_code
}

function cleanup {
    IFS=$oldIFS
    /bin/rm -f $temp_file
}

# Replace all occurences of original file with the newly-specified target file
function replace_file_names {

    sed -e "s!\s$1\s\+|! $2 |!" -i $patch_file
    sed -e "s|diff\s--git\sa/$1\sb/$1|diff --git a/$2 b/$2|" -i $patch_file
    sed -e "s|\([-+]\{3\}\)\s\([ab]\)/$1|\1 \2/$2|" -i $patch_file
}

function prepare_temp_file {

    local temp_file_content="File Specified in Patch|Target File\n-----------------------|-----------\n"
    for file in $(echo ${patch_file_list[@]}); do
	temp_file_content="$temp_file_content\n$file"
    done
    echo -e $temp_file_content | column -t -s"|" > $temp_file
}

# Prepare temporary file in which target files can be specified
function process_temp_file {

    target_file_list=($(cat $temp_file | sed -e '/---.*/d' | sed -e '/File Specified.*/d' | tr -s ' ' | cut -d ' ' -f2))
    target_file_count=${#target_file_list[@]}

    for i in $(seq 0 $(expr $target_file_count - 1)); do
        replace_file_names ${patch_file_list[i]} ${target_file_list[i]}
    done

    if test $patch_file_count != $target_file_count; then
    	return_error "Specified patch modifies $patch_file_count files, you specified $target_file_count target files" 2
    fi
}

while getopts ":f:ih" OPTION;do
    case "$OPTION" in
        i)
	    # Run interactively
	    use_editor=1
	    ;;
        h)
            printf "%s\n" "
Usage: $name [-i] [-f <file_to_patch>] <patch>
 -h display help information
 -i run interactively, using your editor (allows to apply patch to multiple files)
 -f specify file to apply patch to
"
            exit 0
            ;;
	f)
	    use_editor=0
	    # Specify file to apply patch to
	    target_file=$OPTARG
	    ;;
        *)
            return_error "Invalid option: -$OPTARG" 22
            ;;
    esac
done

# Shift to remove getopts arguments
shift $(($OPTIND - 1))

# Test if we are in a Git repo
if test ! -d .git; then
    return_error "Not a Git repository." 2
fi

# Test if only one patch file is supplied as an argument
if test $# -ne 1; then
    return_error "Incorrect number of parameters. Please see: $name -h" 22
fi

# Patch file specified as the last argument
patch_file=${@: -1}

# Test if patch file exists
if test ! -f $patch_file; then
    return_error "Provided patch is not a regular file." 2
fi

# Get a list of files that need to be replaced in the specified patch
patch_file_list=($(head -n $(grep -m 1 -one "^diff --git a/" $patch_file | cut -d: -f1) $patch_file | grep -E "\|" | sed -e "s/\s\(.\+\)\s|.*/\1/"))
patch_file_count=${#patch_file_list[@]}

if test $use_editor -eq 1; then
    prepare_temp_file
    $EDITOR $temp_file
    process_temp_file
else
    # Test if destination file exists
    if test ! -f "$target_file"; then
	return_error "Specified target file is not a regular file." 2
    fi

    # Test if patch modifies only one file
    if test $patch_file_count -gt 1; then
	return_error "Specified patch modifies $patch_file_count files, please use interactive mode to specify multiple target files." 22
    fi

    replace_file_names ${patch_file_list[0]} "$target_file"
fi

# Patch repo with the modified patch file
git am $patch_file