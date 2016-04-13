#!/bin/bash -ex

echo "Build script running as user $(whoami)"

if [ -e "/usr/local/bin/swiftenv" ]; then
	export PATH="/usr/local/bin:$PATH"
fi

eval "$(swiftenv init -)"

swiftenv version

swift build -k dist
swift build --fetch
if ls Packages/*/Tests 1>/dev/null 2>&1; then
	echo "Deleting subpackage tests"
	rm -r Packages/*/Tests
fi
swift build
swift test
