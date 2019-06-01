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
mkdir -p "$HOME/.bin"
for i in "$DOTFILESDIR"/bin/*; do
	scriptFilename="$(basename "$i")"
	maybe_link "$DOTFILESDIR/bin/$scriptFilename" "$HOME/.bin/$scriptFilename"
done

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

# Sublime Text Code
mkdir -p "$HOME/Library/Application Support/Sublime Text 3/Packages/User/"
maybe_link "$DOTFILESDIR/sublime-text/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
if needs_update "$DOTFILESDIR/sublime-text/Sublime Text.icns" "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns"; then
	cp "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns" "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns.backup"
	rm "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns"
	cp "$DOTFILESDIR/sublime-text/Sublime Text.icns" "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns"
fi

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
if [[ ! -e "$HOME/.bin/wpv" ]]; then
	curl https://raw.githubusercontent.com/smilingrobots/wpv/master/wpv.sh > "$HOME/.bin/wpv"
	chmod +x "$HOME/.bin/wpv"
fi

# A8C (personal script for handling Automattic's proxy settings)
if [[ ! -e "$HOME/.bin/a8c.sh" ]]; then
	git clone git@github.com:jorgeatorres/a8c.sh.git /tmp/a8c.sh
	mv /tmp/a8c.sh/a8c.sh "$HOME/.bin"
	chmod +x "$HOME/.bin/a8c.sh"
	rm -rf /tmp/a8c.sh
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
