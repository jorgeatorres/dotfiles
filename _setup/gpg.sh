if [[ ! $(which gpg) ]]; then
	echo "Please install GPG before continuing!"
	exit 1
fi

if ! $(gpg --list-keys 3DC414829569195D1DC48ABE3DBE8B97E5EE00A9 > /dev/null 2>&1); then
	require_1password

	op read "op://Private/GPG Key/public key" | gpg --import

	op read "op://Private/GPG Key/passphrase" > /tmp/mykey.pass
	op read "op://Private/GPG Key/private.asc" | gpg --batch --passphrase-file /tmp/mykey.pass --import
	rm /tmp/mykey.pass
fi
