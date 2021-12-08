if [[ ! $(which gpg) ]]; then
	echo "Please install GPG before continuing!"
	exit 1
fi

if ! $(gpg --list-keys DD7BA8B00EC20D8C20D55473A5EAF0750A6BCAE9 > /dev/null 2>&1); then
	require_1password

	op get document "ef6vthpsuffirnh5hqhg67acoq" > /tmp/mykey.key
	gpg --import /tmp/mykey.key

	op get document "gy3pkac4hbdz7ocrpxaprmtxxm" > /tmp/mykey.key
	op get item "gy3pkac4hbdz7ocrpxaprmtxxm" --fields "passphrase" > /tmp/mykey.pass
	gpg --batch --passphrase-file /tmp/mykey.pass --import /tmp/mykey.key

	rm /tmp/mykey.key
	rm /tmp/mykey.pass
fi
