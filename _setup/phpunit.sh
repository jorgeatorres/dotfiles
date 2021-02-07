

for i in {5..9}; do
	if [[ ! $(which "phpunit$i") ]]; then
		wget -O "$HOME/.bin/phpunit$i" "https://phar.phpunit.de/phpunit-$i.phar"
		chmod +x "$HOME/.bin/phpunit$i"
	fi
done
