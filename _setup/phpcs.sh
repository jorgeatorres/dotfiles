PHPCS_DIR="$HOME/.phpcs"

STANDARDS="
https://github.com/WordPress/WordPress-Coding-Standards
https://github.com/woocommerce/woocommerce-sniffs
https://github.com/PHPCSStandards/PHPCSUtils
https://github.com/PHPCompatibility/PHPCompatibility
"


mkdir -p "$PHPCS_DIR"

if [[ ! $(which phpcs) ]]; then
	wget -O "$PHPCS_DIR/phpcs" https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
	chmod +x "$PHPCS_DIR/phpcs"
	ln -s "$PHPCS_DIR/phpcs" "$HOME/.bin/"
fi

mkdir -p "$PHPCS_DIR/standards"

installed_paths=""
for repo in $STANDARDS; do
	standard=$(basename "$repo")
	
	if [[ ! -e "$PHPCS_DIR/standards/$standard" ]]; then
		 git clone "$repo" "$PHPCS_DIR/standards/$standard" --depth 1
	else
		cd "$PHPCS_DIR/standards/$standard"
		git pull --rebase --quiet
	fi
	
	
	standard_contents="$PHPCS_DIR/standards/$standard"
	# woocommerce-sniffs is a special case.
	if [[ "woocommerce-sniffs" = "$standard" ]]; then
		standard_contents="$standard_contents/src"
	fi
	
	installed_paths="$installed_paths,$standard_contents"
done

installed_paths=${installed_paths:1}

if [[ ! $(phpcs --config-show | grep "$installed_paths") ]]; then
	phpcs --config-set installed_paths "$installed_paths"
fi



