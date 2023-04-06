#!/usr/bin/env bash

PLATFORM=""

function _copy_bash_config() {
    if [ "$PLATFORM" == "linux" ]; then
        folder="linux"
    elif [ "$PLATFORM" == "mac" ]; then
        folder="mac"
    else
        echo "Unknown platform"
        exit 1
    fi
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PLATFORM="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="mac"
elif [[ "$OSTYPE" == "cygwin" ]]; then
    PLATFORM="linux"
elif [[ "$OSTYPE" == "msys" ]]; then
    PLATFORM="linux"
elif [[ "$OSTYPE" == "win32" ]]; then
    echo "Unsupported platform (win32)"
    exit 1
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    PLATFORM="linux"
else
    echo "Unsupported platform"
    exit 1
fi

_copy_bash_config
