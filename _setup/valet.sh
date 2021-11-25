
if ! $(composer global show laravel/valet > /dev/null 2>&1); then
	composer global require laravel/valet
	source ~/.zshrc
fi

if [[ ! $(which mysql) ]]; then
	brew link mysql@5.7
	brew services start mysql@5.7
fi

if [[ ! $(valet links | grep 'phpmyadmin') ]]; then
	brew install phpmyadmin
	cd "${HOMEBREW_PREFIX}/share/phpmyadmin"
	valet link
fi

# Config.
sed -i '' "s/\['auth_type'\] = 'cookie'/\['auth_type'\] = 'config'/" "${HOMEBREW_PREFIX}/etc/phpmyadmin.config.inc.php"
sed -i '' "s/\['AllowNoPassword'\] = false/\['AllowNoPassword'\] = true/" "${HOMEBREW_PREFIX}/etc/phpmyadmin.config.inc.php"
