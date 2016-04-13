#!/bin/bash -ex

echo "Build script running as user $(whoami)"

if [ -e "/usr/local/bin/swiftenv" ]; then
	eval "$(/usr/local/bin/swiftenv init -)"
else
	eval "$(swiftenv init -)"
fi

swiftenv version

swift build -k dist
swift build --fetch
if ls Packages/*/Tests 1>/dev/null 2>&1; then
	echo "Deleting subpackage tests"
	rm -r Packages/*/Tests
fi
swift build
swift test
