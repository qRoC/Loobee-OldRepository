#!/bin/bash

set -e

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    rm -rf /usr/local/clang-3.5.0

    apt-get -qq update
    apt-get install -y clang
fi
