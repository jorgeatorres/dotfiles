
if ! $(composer global show laravel/valet > /dev/null 2>&1); then
	composer global require laravel/valet

	export PATH="$HOME/.composer/vendor/bin:$PATH"
fi

if [[ ! $(which mysql) ]]; then
	brew link mysql@5.7
	brew services start mysql@5.7
fi

valet install

# Set up phpMyAdmin.
if [[ -d "${HOMEBREW_PREFIX}/share/phpmyadmin" && ! $(valet links | grep 'phpmyadmin') ]]; then
	cd "${HOMEBREW_PREFIX}/share/phpmyadmin"
	valet link
fi

if [[ -e "${HOMEBREW_PREFIX}/etc/phpmyadmin.config.inc.php" ]]; then
	sed -i '' "s/\['auth_type'\] = 'cookie'/\['auth_type'\] = 'config'/" "${HOMEBREW_PREFIX}/etc/phpmyadmin.config.inc.php"
	sed -i '' "s/\['AllowNoPassword'\] = false/\['AllowNoPassword'\] = true/" "${HOMEBREW_PREFIX}/etc/phpmyadmin.config.inc.php"
fi
