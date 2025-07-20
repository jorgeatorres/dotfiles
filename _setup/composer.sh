
if [[ ! $(which composer@1) ]]; then
	wget -q -O "$HOME/.bin/composer@1" "https://getcomposer.org/download/1.10.27/composer.phar"
	chmod +x "$HOME/.bin/composer@1"
fi

if [[ ! $(which composer@2) ]]; then
	wget -q -O "$HOME/.bin/composer@2" "https://getcomposer.org/download/2.8.10/composer.phar"
	chmod +x "$HOME/.bin/composer@2"

	# Link Composer 2 by default as "composer".
	[[ ! $(which composer) ]] && ln -s "$HOME/.bin/composer@2" "$HOME/.bin/composer"
fi
