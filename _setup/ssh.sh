# SSH key setup
if [[ ! -e "$HOME/.ssh/config"  ]]; then
	cat <<EOT > "$HOME/.ssh/config"
	Host *
	UseKeychain yes
	AddKeysToAgent yes
	IdentityFile ~/.ssh/id_ed25519
EOT
fi

require_1password

op get document "yi3j4cs6ojawzlwp4e763hrwxq" --output /tmp/ssh.pub
op get document "7ukxxbzsincz3bqsx6p6iwl32e" --output /tmp/ssh.priv

if ! cmp --silent "/tmp/ssh.pub" "$HOME/.ssh/id_ed25519.pub"; then
	mv /tmp/ssh.pub "$HOME/.ssh/id_ed25519.pub"
	chmod 644 "$HOME/.ssh/id_ed25519.pub"
fi

if ! cmp --silent "/tmp/ssh.priv" "$HOME/.ssh/id_ed25519"; then
	mv /tmp/ssh.pub "$HOME/.ssh/id_ed25519"
	chmod 644 "$HOME/.ssh/id_ed25519"
fi

rm -rf /tmp/ssh.{pub,priv}
ssh-add -K
