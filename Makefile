.PHONY: default
default: all

SWIFTC_COMMON_FLAGS = -j 8 -num-threads 8 -warnings-as-errors
SWIFTC_RELEASE_FLAGS = -Ounchecked -gnone -whole-module-optimization -static-stdlib $(SWIFTC_COMMON_FLAGS)
SWIFTC_SAFE_RELEASE_FLAGS = -O -gline-tables-only -whole-module-optimization -static-stdlib $(SWIFTC_COMMON_FLAGS)
SWIFTC_DEBUG_FLAGS = -Onone -g $(SWIFTC_COMMON_FLAGS)

LINKER_DEBUG_FLAGS =
LINKER_RELEASE_FLAGS =

CC_COMMON_FLAGS = -Wextra
CC_DEBUG_FLAGS = $(CC_COMMON_FLAGS)
CC_RELEASE_FLAGS = -Ofast -march=native -ffast-math $(CC_COMMON_FLAGS)

generatePassFlags = $(patsubst %,-$(1) "%",$(2))

.PHONY: all safe-release release
all: clean build test
safe-release: clean build-safe-release test-safe-release
release: clean build-release test-release

.PHONY: build build-sanitize-address build-safe-release build-release
build:
	swift build $(call generatePassFlags,Xswiftc,$(SWIFTC_DEBUG_FLAGS)) $(call generatePassFlags,Xcc,$(CC_DEBUG_FLAGS)) $(call generatePassFlags,Xlinker,$(LINKER_DEBUG_FLAGS))
build-sanitize-address:
	swift build --sanitize=address $(call generatePassFlags,Xswiftc,$(SWIFTC_DEBUG_FLAGS)) $(call generatePassFlags,Xcc,$(CC_DEBUG_FLAGS)) $(call generatePassFlags,Xlinker,$(LINKER_DEBUG_FLAGS))
build-safe-release:
	swift build --configuration release --static-swift-stdlib $(call generatePassFlags,Xswiftc,$(SWIFTC_SAFE_RELEASE_FLAGS)) $(call generatePassFlags,Xcc,$(CC_RELEASE_FLAGS)) $(call generatePassFlags,Xlinker,$(LINKER_RELEASE_FLAGS))
build-release:
	swift build --configuration release --static-swift-stdlib $(call generatePassFlags,Xswiftc,$(SWIFTC_RELEASE_FLAGS)) $(call generatePassFlags,Xcc,$(CC_RELEASE_FLAGS)) $(call generatePassFlags,Xlinker,$(LINKER_RELEASE_FLAGS))

.PHONY: test test-safe-release test-release test-docker
test:
	swift test $(call generatePassFlags,Xswiftc,$(SWIFTC_DEBUG_FLAGS)) $(call generatePassFlags,Xcc,$(CC_DEBUG_FLAGS)) $(call generatePassFlags,Xlinker,$(LINKER_DEBUG_FLAGS))
test-safe-release:
	swift test --configuration release $(call generatePassFlags,Xswiftc,$(filter-out -whole-module-optimization,$(SWIFTC_SAFE_RELEASE_FLAGS)) -g -enable-testing) $(call generatePassFlags,Xcc,$(CC_RELEASE_FLAGS)) $(call generatePassFlags,Xlinker,$(LINKER_RELEASE_FLAGS))
test-release:
	swift test --configuration release $(call generatePassFlags,Xswiftc,$(filter-out -whole-module-optimization,$(SWIFTC_RELEASE_FLAGS)) -g -enable-testing) $(call generatePassFlags,Xcc,$(CC_RELEASE_FLAGS)) $(call generatePassFlags,Xlinker,$(LINKER_RELEASE_FLAGS))
test-docker:
	docker-compose run test

.PHONY: clean
clean:
	swift package clean

.PHONY: xcode
xcode:
	swift package generate-xcodeproj

.PHONY: linuxmain
linuxmain:
	swift test --generate-linuxmain

.PHONY: install-dev-tools
install-dev-tools:
	curl -o scripts/external/gyb.py https://raw.githubusercontent.com/apple/swift/master/utils/gyb.py
	chmod +x scripts/external/gyb.py

.PHONY: gyb
gyb:
	find . -name '*.gyb' | while read file; do scripts/external/gyb.py --line-directive '' -o "$${file%.gyb}" "$$file"; done
