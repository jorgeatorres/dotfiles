
if ! $(composer global show laravel/valet > /dev/null 2>&1); then
	composer global require laravel/valet
fi
