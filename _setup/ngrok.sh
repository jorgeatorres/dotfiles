
if ! $(grep 'authtoken' ~/.ngrok2/ngrok.yml > /dev/null 2>&1); then
	require_1password
	ngrok authtoken `op get item "ngrok.com" --fields "auth token"`
fi
