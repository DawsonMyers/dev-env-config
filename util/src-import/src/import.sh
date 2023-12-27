#!/bin/bash

# Import the utility functions
. ./log.sh
. ./jq_helpers.sh

# Import a script from a registered root directory

# Import a script from a registered root directory
function import() {
    local import_path=$1
    local script_file=""
    local module_loaded=0

    if [[ $import_path =~ ^@ ]]; then
        # Extract the root directory alias and script path from the import path
        local alias=$(echo "$import_path" | cut -d '/' -f 1 | sed 's/@//')
        local script_path=$(echo "$import_path" | cut -d '/' -f 2-)

        if [[ -z $alias || -z $script_path ]]; then
            echo "Error: Invalid import path '$import_path'. Please use the format '@alias/path/to/script'."
            return 1
        fi

        # Retrieve the root directory based on the alias
        local root_directory=$(read_config "root_directories.$alias")

        if [[ -z $root_directory ]]; then
            echo "Error: Unknown root directory alias '$alias'."
            return 1
        fi

        script_file="$root_directory/$script_path"
    else
        # Get the caller's file path
        local caller_file="${BASH_SOURCE[1]}"
        local caller_dir=$(dirname "$caller_file")

        script_file="$caller_dir/$import_path"
    fi

    if [[ ! -f $script_file ]]; then
        echo "Error: Script '$script_file' not found."
        return 1
    fi

    # Check if module is already loaded in current scope
    if [[ -n ${LOADED_MODULES[$script_file]} ]]; then
        module_loaded=1
    else
        # Source the script file and mark it as loaded
        source "$script_file"
        LOADED_MODULES[$script_file]=1
    fi

    # Generate self-executing code to import the script
    local import_code="eval source $script_file"

    # Return the import code and module loaded status
    echo "$import_code:$module_loaded"
}

# Command-line interface
function cli_import() {
    # ...
}

# Parse command-line arguments
# ...
