#!/bin/sh
set -e

cd $(dirname $0)
DIR=$(pwd -P)


# ----------------
# Helper functions
# ----------------

# Sanity Check: due to symlinks, it is best if the dotfiles dir doesn't move. My preferred location is ~/src/dotfiles.
check_dotfiles_location() {
	if [[ "$DIR" != "$HOME/src/dotfiles" && ! -d "$HOME/src/dotfiles" ]]; then
		read -p "Would you like to move this folder to ~/src/dotfiles? (default: Y) [Yn]: " -n 1 -r; echo;

		if [[ ! $REPLY =~ ^[Nn]$ ]]; then
			mkdir -p ${HOME}/src; mv ${DIR} ${HOME}/src/dotfiles; ${HOME}/src/dotfiles/setup.sh $1; exit;
		fi
	fi
}

# Sanity check: if not running from a clone of the repo and SSH keys are configured, clone Git repo to the folder.
maybe_clone_repo() {
	if [[ ! -e "$DIR/.git" && -e "$HOME/.ssh/id_rsa" ]]; then
		REPO_CLONE_DIR=`mktemp -d`
		git clone git@github.com:jorgeatorres/dotfiles.git ${REPO_CLONE_DIR} --quiet
		mv ${REPO_CLONE_DIR}/.git ${DIR}/.git
		rm -rf ${REPO_CLONE_DIR}
	fi
}

# Sign in to 1Password.
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

# Ask for e-mail address.
require_email_address() {
	if [[ -z "$EMAIL_ADDRESS" ]]; then
		local email_apple_id=$(defaults read MobileMeAccounts Accounts | grep AccountID | cut -d \" -f2)
		read -p "Please enter your e-mail address (default: '$email_apple_id'): " -r EMAIL_ADDRESS
		EMAIL_ADDRESS=${EMAIL_ADDRESS:-"$email_apple_id"}
	fi
}

# Run specific setup script.
do_install() {
	shortname=$(basename "$1")

	echo "\033[1;32m=> \033[1;37mRunning \033[1;33m$shortname\033[1;37m...\033[0m"
	cd "$DIR" > /dev/null
	source "$1"
}


# -----
# Setup
# -----

check_dotfiles_location

if [[ -n "$1" && -e "_setup/$1.sh" ]]; then
	do_install _setup/"$1.sh"
	exit
fi


# <scripts>
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
# </scripts>


maybe_clone_repo
