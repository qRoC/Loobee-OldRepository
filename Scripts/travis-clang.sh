#!/bin/bash

set -e

if [[ "$TRAVIS_OS_NAME" == "linux" ]] && [[ -n "$CLANG_VERSION" ]]; then
    rm -rf /usr/local/clang-3.5.0

    apt-get -qq update
    apt-get install -y clang-${CLANG_VERSION}

    update-alternatives --quiet --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION} 100
    update-alternatives --quiet --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION} 100
fi
