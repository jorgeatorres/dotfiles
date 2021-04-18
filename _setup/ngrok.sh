
if ! $(grep 'authtoken' ~/.ngrok2/ngrok.yml > /dev/null 2>&1); then
	eval $(op signin my.1password.com)
	ngrok authtoken `op get item "ngrok.com" --fields "auth token"`
fi
