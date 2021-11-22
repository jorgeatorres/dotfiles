#!/bin/sh

# Xcode is neede for a bunch of stuff.
if [[ ! -e "/Applications/Xcode.app" ]]; then
	echo "Please install Xcode from the App Store before proceeding!"
	exit 1
fi

if [[ ! $(which brew)  ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	source ~/.zshrc

	# Homebrew requires Rosetta on Apple Silicon for some packages.
	if [ "$(uname -m)" = "arm64" ]; then
		sudo softwareupdate --install-rosetta
	fi
fi

# Install packages.
brew bundle check --file="$DIR/homebrew/Brewfile" >/dev/null 2>&1  || {
    brew bundle --file="$DIR/homebrew/Brewfile" --verbose
}
