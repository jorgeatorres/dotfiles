MAILHOG_PATH=`which MailHog`
if [[ -n "$MAILHOG_PATH" ]]; then
	if [ "$(uname -m)" = "arm64" ]; then
		PHP_ETC="/opt/homebrew/etc/php"
	else
		PHP_ETC="/usr/local/etc/php"
	fi

	for dir in $PHP_ETC/*; do
	    dir=${dir%*/}

		if [ ! -e "$dir/conf.d/mailhog.ini" ]; then
			cat <<- EOF > "$dir/conf.d/mailhog.ini"
			[mail function]
			sendmail_path = '$MAILHOG_PATH sendmail'
			EOF
		fi
	done
fi
