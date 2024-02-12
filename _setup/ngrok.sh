# ngrok
if ! $(grep 'authtoken' ~/Library/Application\ Support/ngrok/ngrok.yml > /dev/null 2>&1); then
	require_1password
	ngrok config add-authtoken `op get item "ngrok.com" --fields "auth token"`
fi
