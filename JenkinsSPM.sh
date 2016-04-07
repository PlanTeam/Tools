#!/bin/bash -ex
eval "$(/usr/local/bin/swiftenv init -)"
swift build -k dist
swift build --fetch
if ls Packages/*/Tests 1>/dev/null 2>&1; then
	echo "Deleting subpackage tests"
	rm -r Packages/*/Tests
fi
swift build
swift test
