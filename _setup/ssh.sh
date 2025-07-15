# SSH key setup
if [[ ! -e "$HOME/.ssh/config"  ]]; then
	cat <<EOT > "$HOME/.ssh/config"
	Host *
	UseKeychain yes
	AddKeysToAgent yes
	IdentityFile ~/.ssh/id_ed25519
EOT
fi

mkdir -p ${HOME}/.ssh

require_1password

op read "op://Private/SSH Key/public key" > ${HOME}/.ssh/id_ed25519.pub
op read "op://Private/SSH Key/id_ed25519" > ${HOME}/.ssh/id_ed25519

chmod 600 ${HOME}/.ssh/id_ed25519{,.pub}

APPLE_SSH_ADD_BEHAVIOR=macos ssh-add -K
