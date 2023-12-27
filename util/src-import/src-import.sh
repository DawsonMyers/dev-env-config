#!/bin/bash

# Constants
CONFIG_DIR=~/.config/src-import
CONFIG_FILE=$CONFIG_DIR/src-import.conf.json

# Create configuration directory and file if missing
mkdir -p "$CONFIG_DIR"
touch "$CONFIG_FILE"

# Helper function to read JSON configuration file
function read_config() {
    local key=$1
    jq -r ".$key" "$CONFIG_FILE"
}

# Helper function to write JSON configuration file
function write_config() {
    local key=$1
    local value=$2
    jq ".$key = $value" "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
}

# Helper function to remove key from JSON configuration file
function remove_config_key() {
    local key=$1
    jq "del(.$key)" "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
}

# Helper function to remove array item from JSON configuration file
function remove_config_array_item() {
    local key=$1
    local index=$2
    jq "del(.$key[$index])" "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
}

# Register a root directory with an optional alias
function register_root_directory() {
    local alias=""

    while [[ $# -gt 0 && $1 =~ ^- ]]; do
        case "$1" in
            -a|--alias)
                alias=$2
                shift
                ;;
            *)
                echo "Error: Invalid option: $1"
                return 1
                ;;
        esac
        shift
    done
    local directory=${1:-$(pwd)}

    # Convert relative directory to absolute path
    directory=$(realpath "$directory")

    if [[ ! -d $directory ]]; then
        echo "Error: Directory '$directory' does not exist."
        return 1
    fi

    # Use current directory name as default alias if not provided
    if [[ -z $alias ]]; then
        alias=$(basename "$directory")
    fi

    write_config "root_directories.$alias" "\"$directory\""

    echo "Root directory '$directory' registered with alias '$alias'."
}

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

# Colored logging functions
function log_info() {
    local message=$1
    echo -e "\e[32m[INFO]\e[0m $message"
}

function log_warning() {
    local message=$1
    echo -e "\e[33m[WARNING]\e[0m $message"
}

function log_error() {
    local message=$1
    echo -e "\e[31m[ERROR]\e[0m $message"
}

# Command-line interface for registering root directories
function cli_register_root_directory() {
    local directory=""
    local alias=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -a|--alias)
                alias=$2
                shift 2
                ;;
            *)
                directory=$1
                shift
                ;;
        esac
    done

    register_root_directory "$directory" -a "$alias"
}

# Command-line interface for importing scripts
function cli_import() {
    local import_path=$1

    if [[ -z $import_path ]]; then
        echo "Usage: cli_import <import_path>"
        return 1
    fi

    import "$import_path"
}

# Example usage of the utility library

# Register root directories
# register_root_directory -a scripts
# register_root_directory -a custom /path/to/custom/directory

# Import scripts using the import() function
# import "@scripts/script1.sh"
# import "@custom/script2.sh"

# Command-line interface for registering root directories
# Usage: bash src-import.sh register [options] <directory>
if [[ $1 == "register" ]]; then
    shift
    cli_register_root_directory "$@"
fi

# Command-line interface for importing scripts
# Usage: bash src-import.sh import <import_path>
if [[ $1 == "import" ]]; then
    shift
    cli_import "$@"
fi
