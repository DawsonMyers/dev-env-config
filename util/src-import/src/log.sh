#!/bin/bash

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
