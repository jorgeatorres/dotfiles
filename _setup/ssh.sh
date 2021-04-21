# SSH key setup
if needs_update "$DIR/ssh/id_rsa.pub" "$HOME/.ssh/id_rsa.pub"; then
	mkdir -p "$HOME/.ssh"
	rm -rfv "$HOME/.ssh/{id_rsa,id_rsa.pub}"

cat <<EOT > "$HOME/.ssh/config"
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
EOT

	cp "$DIR/ssh/id_rsa.pub" "$HOME/.ssh/"
	eval $(op signin my.1password.com)
	op get document "7ukxxbzsincz3bqsx6p6iwl32e" > "$HOME/.ssh/id_rsa"
	chmod 644 "$HOME/.ssh/id_rsa.pub"
	chmod 600 "$HOME/.ssh/id_rsa"
	ssh-add -K
fi
