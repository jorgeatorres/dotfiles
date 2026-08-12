if [[ ! -x "$HOME/.bin/catch-mail" ]]; then
	echo "! ~/.bin/catch-mail not found."
	exit 1
fi

if [[ "$(uname -m)" = "arm64" ]]; then
	PHP_ETC="/opt/homebrew/etc/php"
else
	PHP_ETC="/usr/local/etc/php"
fi

for dir in $PHP_ETC/*; do
	dir=${dir%*/}

	rm -f "$dir/conf.d/mailhog.ini" "$dir/conf.d/mailpit.ini"
	cat <<- EOF > "$dir/conf.d/catch-mail.ini"
	[mail function]
	sendmail_path = $HOME/.bin/catch-mail
	EOF
done
