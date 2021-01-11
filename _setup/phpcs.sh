# TODO:
# - Add PHPCompatibility to phpcs standards.

if [[ ! $(which phpcs) ]]; then
	mkdir -p "$HOME/.phpcs"
	wget -O "$HOME/.phpcs/phpcs" https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
	chmod +x "$HOME/.phpcs/phpcs"
	ln -s $HOME/.phpcs/phpcs "$HOME/bin/"
fi

mkdir -p $HOME/.phpcs/standards

# WordPress.
if [[ ! -e "$HOME/.phpcs/standards/wordpress" ]]; then
 	git clone https://github.com/WordPress/WordPress-Coding-Standards.git "$HOME/.phpcs/standards/wordpress" --depth 1
else
	cd "$HOME/.phpcs/standards/wordpress"
	git pull --rebase --quiet
fi

# WooCommerce.
if [[ ! -e "$HOME/.phpcs/standards/woocommerce" ]]; then
 	git clone https://github.com/woocommerce/woocommerce-sniffs "$HOME/.phpcs/standards/woocommerce" --depth 1
else
	cd "$HOME/.phpcs/standards/woocommerce"
	git pull --rebase --quiet
fi

# PHPCSUtils (required by PHPCompatibility).
if [[ ! -e "$HOME/.phpcs/standards/phpcsutils" ]]; then
	git clone https://github.com/PHPCSStandards/PHPCSUtils "$HOME/.phpcs/standards/phpcsutils" --depth 1
else
	cd "$HOME/.phpcs/standards/phpcsutils"
	git pull --rebase --quiet
fi

# PHPCompatibility.
if [[ ! -e "$HOME/.phpcs/standards/phpcompatibility" ]]; then
	git clone https://github.com/PHPCompatibility/PHPCompatibility.git "$HOME/.phpcs/standards/phpcompatibility" --depth 1
else
	cd "$HOME/.phpcs/standards/phpcompatibility"
	git pull --rebase --quiet
fi

phpcs --config-set installed_paths "$HOME/.phpcs/standards/wordpress,$HOME/.phpcs/standards/woocommerce/src,$HOME/.phpcs/standards/phpcsutils,$HOME/.phpcs/standards/phpcompatibility"



