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
maybe_link "$DOTFILESDIR/zsh/zshrc" "$HOME/.zshrc"

# bin/
rm -rf /tmp/bin.git
git clone git@github.com:jorgeatorres/bin.git /tmp/bin.git --quiet --depth=1
sh /tmp/bin.git/install.sh
rm -rf /tmp/bin.git

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
if [[ ! -e "/usr/local/bin/brew" ]]; then /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; fi

brew bundle check --file="$DOTFILESDIR/homebrew/Brewfile" >/dev/null 2>&1  || {
    brew bundle --file="$DOTFILESDIR/homebrew/Brewfile"
}

#DOTFILES_BREWFILE_HASH=$(md5 -q "$DOTFILESDIR/homebrew/Brewfile")
#if [[ -e "$HOME/.dotfiles-brewfile-hash" ]]; then INSTALLED_BREWFILE_HASH=$(cat "$HOME/.dotfiles-brewfile-hash"); else INSTALLED_BREWFILE_HASH=""; fi
#
#if [[ $INSTALLED_BREWFILE_HASH != $DOTFILES_BREWFILE_HASH ]]; then
#	brew bundle --file="$DOTFILESDIR/homebrew/Brewfile" || true
#	echo "$DOTFILES_BREWFILE_HASH" > "$HOME/.dotfiles-brewfile-hash"
#fi

# Day One CLI
if [[ ! $(which dayone2) ]]; then sudo bash /Applications/Day\ One.app/Contents/Resources/install_cli.sh; fi

# Sublime Text Code
# mkdir -p "$HOME/Library/Application Support/Sublime Text 3/Packages/User/"
# maybe_link "$DOTFILESDIR/sublime-text/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
# if needs_update "$DOTFILESDIR/sublime-text/Sublime Text.icns" "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns"; then
# 	cp "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns" "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns.backup"
# 	rm "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns"
# 	cp "$DOTFILESDIR/sublime-text/Sublime Text.icns" "/Applications/Sublime Text.app/Contents/Resources/Sublime Text.icns"
# fi

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

cat <<EOT > "$HOME/.ssh/config"
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
EOT

	cp "$DOTFILESDIR/ssh/id_rsa.pub" "$HOME/.ssh/"
	eval $(op signin my.1password.com j@jorgetorres.co)
	op get document "7ukxxbzsincz3bqsx6p6iwl32e" > "$HOME/.ssh/id_rsa"
	chmod 644 "$HOME/.ssh/id_rsa.pub"
	chmod 600 "$HOME/.ssh/id_rsa"
	ssh-add -K
fi

# Laravel
if [[ ! -e "/usr/local/bin/valet" ]]; then
    composer global require laravel/valet
    export PATH="$PATH:$HOME/.composer/vendor/bin"
    valet install
fi

# Configure Mailhog.
if ! grep -Eq '^relayhost[ ]*=[ ]*\[localhost\]:1025' /etc/postfix/main.cf; then
	sudo sed -i -e '$a\
	relayhost = [localhost]:1025\
	\
	' /etc/postfix/main.cf

	brew services restart mailhog
	sudo launchctl stop org.postfix.master
	sudo launchctl start org.postfix.master
fi
