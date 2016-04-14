#!/bin/bash -ex

# Use like this:
# #!/bin/bash -ex
# bash <(curl -s https://raw.githubusercontent.com/PlanTeam/Tools/master/CI.sh)

echo "Build script running as user $(whoami) in directory $(pwd)"

if [ -e "/usr/local/bin/swiftenv" ]; then
	export PATH="/usr/local/bin:$PATH"
fi

eval "$(swiftenv init -)"

swiftenv version

swift build --clean dist
swift build --fetch
if ls Packages/*/Tests 1>/dev/null 2>&1; then
	echo "Deleting subpackage tests"
	rm -r Packages/*/Tests
fi
swift build

if [ -e "Tools/testprep.sh" ]; then
	cd Tools
	./testprep.sh
	cd ..
fi

swift test