## Loobee is a library of Swift components.

**WORK IN PROGRESS**

![WIP](https://img.shields.io/badge/status-WIP-red.svg?style=flat)
[![Build Status - Master](https://travis-ci.org/qRoC/Loobee.svg?branch=master)](https://travis-ci.org/qRoC/Loobee)
![macOS](https://img.shields.io/badge/Swift-4.0-green.svg?style=flat)
![Platforms](https://img.shields.io/badge/platforms-OS%20X%20%7C%20Linux%20-green.svg?style=flat)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)

## Summary

Swift is a set of components for the Swift programming language that provide support for tasks and structures such as 
`memory`, `byte`, `logger`, `concurrency`, `atomic`, `thread`, `container`, `environment`, `time`, etc.

## Table of Contents
* [Features](#features)
* [Getting Started](#getting-started)
* [Contributing to Loobee](#contributing-to-loobee)
* [Contact](#contact)

## Features

 - [ ] [Byte](https://github.com/qRoC/Loobee/tree/master/Sources/Loobee/Byte)
    - [x] `Byte` type.
    - [ ] `ByteBuffer`.
 - [ ] [Concurrency](https://github.com/qRoC/Loobee/tree/master/Sources/Loobee/Concurrency)
     - [x] `Atomic` types.
     - [ ] `Threads`.
 - [ ] [Container](https://github.com/qRoC/Loobee/tree/master/Sources/Loobee/Container)
     - [ ] `Container`.
 - [ ] [Environment](https://github.com/qRoC/Loobee/tree/master/Sources/Loobee/Environment)
     - [x] `Environment`.
     - [x] `CpuId`.
 - [ ] [Error](https://github.com/qRoC/Loobee/tree/master/Sources/Loobee/Error)
     - [x] `Errors` base types.
 - [ ] [Logger](https://github.com/qRoC/Loobee/tree/master/Sources/Loobee/Logger)
    - [x] `Logger` domain.
    - [ ] `File` logger
 - [ ] [Memory](https://github.com/qRoC/Loobee/tree/master/Sources/Loobee/Memory)
     - [x] `Malloc allocator`.
     - [ ] `Small block allocator`
 - [ ] [Scope](https://github.com/qRoC/Loobee/tree/master/Sources/Loobee/Scope)
     - [x] `IndirectBox`.
 - [ ] [Time](https://github.com/qRoC/Loobee/tree/master/Sources/Loobee/Time)
     - [ ] `Steady` time.
     - [ ] `System` time.

## Getting Started

Loobee works and tested on Ubuntu and MacOS.

Make commands:
 - `build` - build debug version
 - `build-safe-release` - build release with with bounds check and minimum debug info
 - `build-release` - full performance
 - `test`, `test-safe-release`, `test-release` - run tests
 - `test-docker` - run tests in docker container (need `docker-env` target).
 - `clean` - clean
 - `xcode` - generate Xcode project
 
For customize build create `Makefile.in.$(USERNAME)`:

Sample file content:

```
CC_RELEASE_FLAGS += -fcolor-diagnostics
CC_DEBUG_FLAGS += -fcolor-diagnostics

docker-run:
	@docker-machine start loobee || true

.PHONY: docker-env
docker-env: docker-run
	$(eval DOCKER_ENV := $(shell docker-machine env loobee))
```

## Contributing to Loobee

All improvements to Loobee are very welcome!

## Contact
[qRoC](https://github.com/qRoC) is the author and maintainer of Loobee. Feel free contact him directly via [email](mailto:admin@qroc.pro).

If you have a question about this library, we recommend [opening an issue](https://github.com/qRoC/Loobee/issues/new).

