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
	cd "$DIR" > /dev/null
	source "$1"
}


do_install _setup/dotfiles.sh
do_install _setup/homebrew.sh
do_install _setup/ssh.sh

do_install _setup/dayone.sh
do_install _setup/vscode.sh

do_install _setup/bin.sh
do_install _setup/bin-private.sh

do_install _setup/wp-cli.sh
do_install _setup/mailhog.sh
do_install _setup/phpunit.sh
do_install _setup/phpcs.sh
do_install _setup/valet.sh
