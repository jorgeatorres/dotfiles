# ----------------
# Helper functions
# ----------------

# Sign in to 1Password.
require_1password() {
	if [[ ! $(which op) ]]; then
		echo "! Please install 1Password before continuing."
		exit 1
	fi

	# If we have a valid session there's no need to sign in again.
	if $(env | grep ^OP_SESSION --quiet); then
		return 0
	fi

	if ! $(op account list | grep my > /dev/null); then
		op account add --address my.1password.com --email "$(get_email_address)"
	fi

	local token=$(op signin --account my --raw)

	# App integration is enabled. Authentication happens via 1Password app.
	if [[ -z "$token" ]]; then
		return 0
	else
		eval $(op signin --session "$token")
	fi
}

# Find user e-mail address.
get_email_address() {
	local email=$(defaults read MobileMeAccounts Accounts | grep AccountID | cut -d \" -f2)

	while [[ -z "$email" ]]; do
		read "email?Please enter your e-mail address: "
	done

	echo "$email"
}

# Run specific setup script.
do_install() {
	shortname=$(basename "$1")

	cd "$DIR" > /dev/null

	if [[ ! -e "$1" ]]; then
		echo "! $1 not found."
		exit 1
	fi

	echo "\033[1;32m=> \033[1;37mRunning \033[1;33m$shortname\033[1;37m...\033[0m"
	source "$1" || {
		echo "! $shortname failed."
		exit 1
	}
}
