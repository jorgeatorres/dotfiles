# SSH key setup
mkdir -p ${HOME}/.ssh
chmod 700 ${HOME}/.ssh

if [[ ! -e "$HOME/.ssh/config"  ]]; then
	cat <<EOT > "$HOME/.ssh/config"
	Host *
	UseKeychain yes
	AddKeysToAgent yes
	IdentityFile ~/.ssh/id_ed25519
EOT
fi


require_1password

(
	umask 077
	op read "op://Private/SSH Key/public key" > ${HOME}/.ssh/id_ed25519.pub
	op read "op://Private/SSH Key/id_ed25519" > ${HOME}/.ssh/id_ed25519
)

chmod 600 ${HOME}/.ssh/id_ed25519{,.pub}

ssh-add --apple-use-keychain
