#!/bin/bash

set -e

if [[ -n "$BUILD_LINK" ]]; then
  if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    mkdir Swift
    wget --no-verbose ${BUILD_LINK} -O Swift.tar.gz
    tar xzf Swift.tar.gz -C Swift --strip 1
    export PATH="${PWD}/Swift/usr/bin:${PATH}"
  elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    curl -o swift-osx.pkg -L ${BUILD_LINK}
    sudo installer -pkg swift-osx.pkg -target /
    export TOOLCHAINS=swift
  fi
fi
