
if [[ ! $(which wp) ]]; then
	wget -O "$HOME/.bin/wp" https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /tmp/wp-cli.phar
	chmod +x "$HOME/.bin/wp"
else
	wp cli update --yes --quiet
fi
