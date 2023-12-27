#!/bin/bash

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
