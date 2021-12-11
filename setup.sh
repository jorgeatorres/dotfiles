#!/bin/sh
set -e

cd $(dirname $0)
DIR=$(pwd -P)

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

require_1password() {
	if [[ ! $(which op) ]]; then
		echo "! Please install 1Password before continuing."
		exit 1
	fi

	local token="$OP_SESSION_my"

	if [[ -z "$token" ]]; then
		# Do we need to sign in for the first time?
		if [[ ! $(op signin -l | grep my) ]]; then
			require_email_address
			token=$(op signin my "$EMAIL_ADDRESS" -r)
		else
			token=$(op signin my -r)
		fi

		if [[ -z "$token" ]]; then
			echo "! Error signing in to 1Password"
			exit 1
		fi

		eval $(op signin --session "$token")
	fi
}

require_email_address() {
	if [[ -z "$EMAIL_ADDRESS" ]]; then
		local email_apple_id=$(defaults read MobileMeAccounts Accounts | grep AccountID | cut -d \" -f2)
		read -p "Please enter your e-mail address (default: '$email_apple_id'): " -r EMAIL_ADDRESS
		EMAIL_ADDRESS=${EMAIL_ADDRESS:-"$email_apple_id"}
	fi
}

# Maybe run just one of the setup scripts (if passed as arg).
if [[ -n "$1" ]]; then
	do_install _setup/"$1.sh"
	exit
fi

do_install _setup/homebrew.sh
do_install _setup/ssh.sh

do_install _setup/dotfiles.sh
do_install _setup/gpg.sh

do_install _setup/dayone.sh
do_install _setup/vscode.sh
do_install _setup/wp-cli.sh
do_install _setup/mailhog.sh
do_install _setup/ngrok.sh
do_install _setup/phpunit.sh
do_install _setup/composer.sh
do_install _setup/phpcs.sh
do_install _setup/valet.sh

do_install _setup/macos.sh
do_install _setup/private.sh
