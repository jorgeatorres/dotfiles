#!/bin/sh
set -e

DOTFILESDIRREL=$(dirname $0)
cd $DOTFILESDIRREL/
DOTFILESDIR=$(pwd -P)
DIR="$DOTFILESDIR"

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

do_install() {
	shortname=$(basename "$1")

	echo "\033[1;32m=> \033[1;37mRunning \033[1;33m$shortname\033[1;37m...\033[0m"
	cd "$DIR" > /dev/null
	source "$1"
}

# Maybe run just one of the setup scripts (if passed as arg).
if [[ -n "$1" ]]; then
	do_install _setup/"$1.sh"
	exit
fi

do_install _setup/dotfiles.sh
do_install _setup/homebrew.sh
do_install _setup/ssh.sh
do_install _setup/gpg.sh

do_install _setup/dayone.sh
do_install _setup/vscode.sh

do_install _setup/bin.sh
do_install _setup/private.sh

do_install _setup/wp-cli.sh
do_install _setup/mailhog.sh
do_install _setup/phpunit.sh
do_install _setup/composer.sh
do_install _setup/phpcs.sh
do_install _setup/valet.sh
