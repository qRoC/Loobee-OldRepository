**Loobee Swift library (WIP)**

`swift`, `loobee`, `memory`, `byte`, `logger`, `concurrency`, `atomic`,
`thread`, `container`, `environment`, `time`.

**WORK IN PROGRESS**

My version `Makefile.in.$(USERNAME)`:

```
SWIFT_FLAGS += --color always

CC_RELEASE_FLAGS += -fcolor-diagnostics
CC_DEBUG_FLAGS += -fcolor-diagnostics

docker-run:
	@docker-machine start loobee || true

.PHONY: docker-env
docker-env: docker-run
	$(eval DOCKER_ENV := $(shell docker-machine env loobee))
```

Make commands:
 - `build` - build debug version
 - `build-safe-release` - build release with with bounds check and minimum debug info
 - `build-release` - full performance
 - `test`, `test-safe-release`, `test-release` - run tests
 - `test-docker` - run tests in docker container (need `docker-env` target).
 - `clean` - clean
 - `xcode` - generate Xcode project
