
if ! $(composer global show laravel/valet > /dev/null 2>&1); then
	composer global require laravel/valet
fi

if [[ ! $(which mysql) ]]; then
	brew link mysql@5.7
fi

if [[ ! $(valet links | grep 'phpmyadmin') ]]; then
	brew install phpmyadmin

	# AllowNoPassword.
	sed -i '' "s/\['AllowNoPassword'\] = false/\['AllowNoPassword'\] = true/g" "${HOMEBREW_PREFIX}/etc/phpmyadmin.config.inc.php"

	cd "${HOMEBREW_PREFIX}/share/phpmyadmin"
	valet link
fi
