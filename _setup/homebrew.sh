#!/bin/sh

if [[ ! -e "/usr/local/bin/brew" ]]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
fi

brew bundle check --file="$DIR/homebrew/Brewfile" >/dev/null 2>&1  || {
    brew bundle --file="$DIR/homebrew/Brewfile"
}
