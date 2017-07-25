#!/bin/bash

set -e

if [[ "$TRAVIS_OS_NAME" == "linux" ]] && [[ -n "$CLANG_VERSION" ]]; then
    apt-get update > /dev/null
    apt-get install -y clang-${CLANG_VERSION} > /dev/null
    update-alternatives --quiet --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 100
    update-alternatives --quiet --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 100
fi
