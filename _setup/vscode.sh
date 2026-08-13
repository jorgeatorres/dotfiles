if [[ ! $(which code) ]]; then
	echo "! code CLI not found, skipping."
	return
fi

CODE_USER="$HOME/Library/Application Support/Code/User"
mkdir -p "$CODE_USER"

[[ -L "$CODE_USER/settings.json" ]] || ln -sfv "$DIR/vscode/settings.json" "$CODE_USER/settings.json"
[[ -L "$CODE_USER/keybindings.json" ]] || ln -sfv "$DIR/vscode/keybindings.json" "$CODE_USER/keybindings.json"

INSTALLED_EXTENSIONS="$(code --list-extensions)"
for EXTENSION in $(cat "$DIR/vscode/extensions-list"); do
	if ! echo "$INSTALLED_EXTENSIONS" | grep -qi "^$EXTENSION$"; then
		code --install-extension "$EXTENSION"
	fi
done
