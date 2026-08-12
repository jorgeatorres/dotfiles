#!/bin/sh
set -e

cd $(dirname $0)
DIR=$(pwd -P)


# Because dotfiles are symlinked, ensure we're running from the expected location.
if [[ "${DIR}" != "${HOME}/src/dotfiles" ]] && [[ ! -d "${HOME}/src/dotfiles" ]]; then
	read -p "Would you like to move this folder to ~/src/dotfiles? (default: Y) [Yn]: " -n 1 -r; echo;
	if [[ ! $REPLY =~ ^[Nn]$ ]]; then
		mkdir -p ${HOME}/src; mv ${DIR} ${HOME}/src/dotfiles; ${HOME}/src/dotfiles/setup.sh $1; exit;
	fi
fi

# Install!
source ${DIR}/_helpers.sh

if [[ -n "$1" ]]; then
	do_install "_setup/$1.sh"
	exit
fi


do_install _setup/homebrew.sh

do_install _setup/ssh.sh
do_install _setup/dotfiles.sh
do_install _setup/gpg.sh

do_install _setup/dotfiles-repo.sh

do_install _setup/catch-mail.sh
do_install _setup/phpunit.sh
do_install _setup/composer.sh
do_install _setup/valet.sh
do_install _setup/wp-cli.sh
do_install _setup/xdebug.sh
do_install _setup/nvm.sh

do_install _setup/dayone.sh
do_install _setup/vscode.sh

do_install _setup/private.sh
do_install _setup/macos.sh
