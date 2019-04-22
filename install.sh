#!/bin/sh
set -e

DOTFILESDIRREL=$(dirname $0)
cd $DOTFILESDIRREL/
DOTFILESDIR=$(pwd -P)

# bash
ln -sfv "$DOTFILESDIR/bash/bashrc" "$HOME/.bashrc"
ln -sfv "$DOTFILESDIR/bash/profile" "$HOME/.profile"

# bin/
if [[ -d "$HOME/.bin" ]]; then
    rm -rv "$HOME/.bin"
fi
ln -sv "$DOTFILESDIR/bin"  "$HOME/.bin"

# editorconfig
ln -sfv "$DOTFILESDIR/editorconfig/editorconfig" "$HOME/.editorconfig"

# git
ln -sfv "$DOTFILESDIR/git/gitconfig" "$HOME/.gitconfig"
ln -sfv "$DOTFILESDIR/git/gitignore" "$HOME/.gitignore"

# nano
ln -sfv "$DOTFILESDIR/nano/nanorc" "$HOME/.nanorc"

# vim
ln -sfv "$DOTFILESDIR/vim/vimrc" "$HOME/.vimrc"
ln -sfv "$DOTFILESDIR/vim/gvimrc" "$HOME/.gvimrc"

# Homebrew
if [[ ! -e "/usr/local/bin/brew" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
ln -sfv "$DOTFILESDIR/homebrew/Brewfile" "$HOME/.Brewfile"
brew bundle --global || true

# Visual Studio Code
mkdir -p "$HOME/Library/Application Support/Code/User"
ln -sfv "$DOTFILESDIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
ln -sfv "$DOTFILESDIR/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

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

# SSH key setup.
mkdir -p "$HOME/.ssh"
rm -rfv "$HOME/.ssh/{id_rsa,id_rsa.pub}"
cp "$DOTFILESDIR/ssh/id_rsa.pub" "$HOME/.ssh/"
eval $(op signin my.1password.com j@jorgetorres.co)
op get document "7ukxxbzsincz3bqsx6p6iwl32e" > "$HOME/.ssh/id_rsa"
ssh-add -K

# Laravel.
if [[ ! -e "/usr/local/bin/valet" ]]; then
    composer global require laravel/valet
    export PATH="$PATH:$HOME/.composer/vendor/bin"
    valet install
fi

# wpv
curl https://raw.githubusercontent.com/smilingrobots/wpv/master/wpv.sh > /usr/local/bin/wpv
chmod +x /usr/local/bin/wpv

# PHP coding standards
mkdir -p "$HOME/.phpcs"

if [[ ! -d "$HOME/.phpcs/wordpress" ]]; then
	git clone git@github.com:WordPress-Coding-Standards/WordPress-Coding-Standards.git "$HOME/.phpcs/wordpress"
fi

if [[ ! -d "$HOME/.phpcs/prospress" ]]; then
	git clone git@github.com:Prospress/prospress-coding-standards.git "$HOME/.phpcs/prospress"
fi

phpcs --config-set installed_paths "$HOME/.phpcs/wordpress,$HOME/.phpcs/prospress"
