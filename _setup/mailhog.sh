
for dir in /usr/local/etc/php/*; do
    dir=${dir%*/}

	if [ ! -e "$dir/conf.d/mailhog.ini" ]; then
		cat <<- EOF > "$dir/conf.d/mailhog.ini"
		[mail function]
		sendmail_path = '/usr/local/bin/MailHog sendmail'
		EOF
	fi
done
