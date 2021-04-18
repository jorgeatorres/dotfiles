
if ! $(gpg --list-keys DD7BA8B00EC20D8C20D55473A5EAF0750A6BCAE9 > /dev/null 2>&1); then
	eval $(op signin my.1password.com)

	op get document "ef6vthpsuffirnh5hqhg67acoq" > /tmp/mykey.key
	gpg --import /tmp/mykey.key

	op get document "gy3pkac4hbdz7ocrpxaprmtxxm" > /tmp/mykey.key
	gpg --import /tmp/mykey.key

	rm /tmp/mykey.key
fi
