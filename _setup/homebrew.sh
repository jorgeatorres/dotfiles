#!/bin/sh
if [[ ! $(which brew)  ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


brew bundle check --file="$DIR/homebrew/Brewfile" >/dev/null 2>&1  || {
    brew bundle --file="$DIR/homebrew/Brewfile"
}
