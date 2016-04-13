#!/bin/bash -ex

# Run this script by adding a jenkins build script with the following contents:
# #!/bin/bash -ex
# bash <(curl -s https://raw.githubusercontent.com/PlanTeam/Tools/master/JenkinsSPM.sh)

echo "Build script running as user $(whoami) in directory $(pwd)"

if [ -e "$HOME/.bashrc" ]; then
	$HOME/.bashrc
fi

if [ -e "$HOME/.bash_profile" ]; then
	$HOME/.bash_profile
fi

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
