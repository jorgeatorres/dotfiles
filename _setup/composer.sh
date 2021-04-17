
if [[ ! $(which composer1) ]]; then
	wget -O "$HOME/.bin/composer1" "https://getcomposer.org/download/1.10.17/composer.phar"
	chmod +x "$HOME/.bin/composer1"
fi
