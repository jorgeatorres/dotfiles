# SSH key setup
if [[ ! -e "$HOME/.ssh/config"  ]]; then
	cat <<EOT > "$HOME/.ssh/config"
	Host *
	UseKeychain yes
	AddKeysToAgent yes
	IdentityFile ~/.ssh/id_rsa
EOT
fi

require_1password

op get document "yi3j4cs6ojawzlwp4e763hrwxq" --output /tmp/ssh.pub
op get document "7ukxxbzsincz3bqsx6p6iwl32e" --output /tmp/ssh.priv

if ! cmp --silent "/tmp/ssh.pub" "$HOME/.ssh/id_rsa.pub"; then
	mv /tmp/ssh.pub "$HOME/.ssh/id_rsa.pub"
	chmod 644 "$HOME/.ssh/id_rsa.pub"
fi

if ! cmp --silent "/tmp/ssh.priv" "$HOME/.ssh/id_rsa"; then
	mv /tmp/ssh.pub "$HOME/.ssh/id_rsa"
	chmod 644 "$HOME/.ssh/id_rsa"
fi

rm -rf /tmp/ssh.{pub,priv}
ssh-add -K
