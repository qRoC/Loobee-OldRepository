#!/bin/bash

set -e

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    apt-get -qq update
    apt-get install -y clang libicu-dev libblocksruntime0
fi
