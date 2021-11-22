if [[ ! -e "$(gem env gemdir)/bin/solargraph" ]]; then
	gem install solargraph
fi

if [[ ! -e "/usr/local/bin/solargraph" ]]; then
	sudo ln -s $(gem env gemdir)/bin/solargraph /usr/local/bin
fi

# Visual Studio Code
mkdir -p "$HOME/Library/Application Support/Code/User"
maybe_link "$DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
maybe_link "$DIR/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

INSTALLED_EXTENSIONS="$(code --list-extensions)"
for EXTENSION in $(cat "$DIR/vscode/extensions-list")
do
    if echo "$INSTALLED_EXTENSIONS" | grep -q "$EXTENSION"
    then
        true;
    else
        code --install-extension "$EXTENSION"
    fi
done
