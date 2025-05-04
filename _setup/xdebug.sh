if ! pecl info xdebug > /dev/null 2>&1; then
	pecl install xdebug
fi

PHP_CONF_FILE=$(php -r "echo php_ini_loaded_file();")
PHP_CONF_FILE_DIR=$(dirname "$PHP_CONF_FILE")

# Remove 'zend_extension="xdebug.so"' from the top of the php.ini file.
sed -i '' '/zend_extension="xdebug.so"/d' "$PHP_CONF_FILE"

if [[ ! -e "$PHP_CONF_FILE_DIR/conf.d/ext-xdebug.ini" ]]; then
	# ==============
	# Config Options
	# ==============
	# xdebug.mode = off | develop | debug | coverage | gcstats | profile | trace
	#   'debug' is for step debugging and 'develop' includes var_dump() helper. Can be overridden by XDEBUG_MODE env var.
	#   See https://xdebug.org/docs/all_settings#mode.
	#
	# xdebug.start_with_request = yes | trigger | default
	#   'trigger' will check whether XDEBUG_TRIGGER is set as an $_ENV, $_GET, $_POST or $_COOKIE variable.
	#   See https://xdebug.org/docs/step_debug.

	cat <<- EOF > "$PHP_CONF_FILE_DIR/conf.d/ext-xdebug.ini"
		[xdebug]
		zend_extension="xdebug.so"
		xdebug.var_display_max_data=-1
		xdebug.var_display_max_depth=-1
		xdebug.mode=debug,develop
		xdebug.start_with_request=trigger
	EOF

	brew services restart php
fi
