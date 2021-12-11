# ~/.bin
mkdir -p "$HOME/.bin"
ln -sfv "$DIR/bin/pdf-reduce-size" "$HOME/.bin/pdf-reduce-size"
# zshrc
maybe_link "$DIR/zsh/zshrc" "$HOME/.zshrc"

# editorconfig
maybe_link "$DIR/editorconfig/editorconfig" "$HOME/.editorconfig"

# ---
# Git
# ---
maybe_link "$DIR/git/gitconfig" "$HOME/.gitconfig"
maybe_link "$DIR/git/gitignore" "$HOME/.gitignore"

if [[ ! -e "$HOME/.user.gitconfig" ]]; then
	require_1password
	require_email_address

	GIT_FULL_NAME=$(id -F)
	GITHUB_USER=$(op get item "GitHub" --fields "username")

	cat <<EOF > "$HOME/.user.gitconfig"
[user]
	name = $GIT_FULL_NAME
	email = $EMAIL_ADDRESS
[github]
	user = $GITHUB_USER
EOF

fi

# vim
mkdir -p "$HOME/.vim"
maybe_link "$DIR/vim/vimrc" "$HOME/.vim/vimrc"
maybe_link "$DIR/vim/gvimrc" "$HOME/.vim/gvimrc"

for vimfile in "$DIR"/vim/*.vim; do
	maybe_link "$vimfile" "$HOME/.vim/$(basename $vimfile)"
done

# go
mkdir -p "$HOME/.go"

source ~/.zshrc
