#!/bin/sh
set -e

DOTFILESDIRREL=$(dirname $0)
cd $DOTFILESDIRREL/
DOTFILESDIR=$(pwd -P)

needs_update() {
	if [[ ! -e "$2" ]]; then
		return 0
	fi

	CHECKSUM1=$(md5 -q "$1")
	CHECKSUM2=$(md5 -q "$2")

	if [[ "$CHECKSUM1" != "$CHECKSUM2" ]]; then
		return 0
	fi

	return 1
}

maybe_link() {
	if needs_update "$1" "$2"; then
		ln -sfv "$1" "$2"
	fi
}

# bash
maybe_link "$DOTFILESDIR/bash/bashrc" "$HOME/.bashrc"
maybe_link "$DOTFILESDIR/bash/profile" "$HOME/.profile"

# bin/
if [[ -d "$HOME/.bin" ]]; then
    rm -rv "$HOME/.bin"
fi
ln -sv "$DOTFILESDIR/bin"  "$HOME/.bin"

# editorconfig
maybe_link "$DOTFILESDIR/editorconfig/editorconfig" "$HOME/.editorconfig"

# git
maybe_link "$DOTFILESDIR/git/gitconfig" "$HOME/.gitconfig"
maybe_link "$DOTFILESDIR/git/gitignore" "$HOME/.gitignore"

# nano
#ln -sfv "$DOTFILESDIR/nano/nanorc" "$HOME/.nanorc"

# vim
maybe_link "$DOTFILESDIR/vim/vimrc" "$HOME/.vimrc"
maybe_link "$DOTFILESDIR/vim/gvimrc" "$HOME/.gvimrc"


# Homebrew
if [[ ! -e "/usr/local/bin/brew" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
ln -sfv "$DOTFILESDIR/homebrew/Brewfile" "$HOME/.Brewfile"
brew bundle --global || true

# Visual Studio Code
mkdir -p "$HOME/Library/Application Support/Code/User"
maybe_link "$DOTFILESDIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
maybe_link "$DOTFILESDIR/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

INSTALLED_EXTENSIONS="$(code --list-extensions)"
for EXTENSION in $(cat "$DOTFILESDIR/vscode/extensions-list")
do
    if echo "$INSTALLED_EXTENSIONS" | grep -q "$EXTENSION"
    then
        true;
    else
        code --install-extension "$EXTENSION"
    fi
done

# SSH key setup
if needs_update "$DOTFILESDIR/ssh/id_rsa.pub" "$HOME/.ssh/id_rsa.pub"; then
	mkdir -p "$HOME/.ssh"
	rm -rfv "$HOME/.ssh/{id_rsa,id_rsa.pub}"
	cp "$DOTFILESDIR/ssh/id_rsa.pub" "$HOME/.ssh/"
	eval $(op signin my.1password.com j@jorgetorres.co)
	op get document "7ukxxbzsincz3bqsx6p6iwl32e" > "$HOME/.ssh/id_rsa"
	ssh-add -K
fi

# Laravel
if [[ ! -e "/usr/local/bin/valet" ]]; then
    composer global require laravel/valet
    export PATH="$PATH:$HOME/.composer/vendor/bin"
    valet install
fi

# wpv
if [[ ! -e "/usr/local/bin/wpv" ]]; then
	curl https://raw.githubusercontent.com/smilingrobots/wpv/master/wpv.sh > /usr/local/bin/wpv
	chmod +x /usr/local/bin/wpv
fi

# PHPCS
mkdir -p "$HOME/.phpcs"

if [[ ! -d "$HOME/.phpcs/wordpress" ]]; then
	git clone git@github.com:WordPress-Coding-Standards/WordPress-Coding-Standards.git "$HOME/.phpcs/wordpress"
fi

if [[ ! -d "$HOME/.phpcs/prospress" ]]; then
	git clone git@github.com:Prospress/prospress-coding-standards.git "$HOME/.phpcs/prospress"
fi

phpcs --config-set installed_paths "$HOME/.phpcs/wordpress,$HOME/.phpcs/prospress"