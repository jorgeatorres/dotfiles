
if [[ ! $(which composer@1) ]]; then
	wget -O "$HOME/.bin/composer@1" "https://getcomposer.org/download/1.10.17/composer.phar"
	chmod +x "$HOME/.bin/composer@1"
fi

if [[ ! $(which composer@2) ]]; then
	wget -O "$HOME/.bin/composer@2" "https://getcomposer.org/download/2.1.12/composer.phar"
	chmod +x "$HOME/.bin/composer@2"
fi

# Link Composer 2 by default as "composer".
if [[ ! $(which composer) ]]; then
	ln -s "$HOME/.bin/composer@2" "$HOME/.bin/composer"
fi
