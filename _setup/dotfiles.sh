# ~/.bin
mkdir -p "$HOME/.bin"
for binfile in ${DIR}/bin/*; do
	[[ -L "${HOME}/.bin/$(basename $binfile)" ]] && continue
	ln -sfv "$binfile" "$HOME/.bin"
done

# Go
mkdir -p "$HOME/.go"

# zshrc
[[ -L "${HOME}/.zshrc" ]] || ln -sfv "$DIR/zsh/zshrc" "$HOME/.zshrc"

# editorconfig
[[ -L "${HOME}/.editorconfig" ]] || ln -sfv "$DIR/editorconfig/editorconfig" "$HOME/.editorconfig"

# Git
[[ -L "${HOME}/.gitconfig" ]] || ln -sfv "$DIR/git/gitconfig" "$HOME/.gitconfig"
[[ -L "${HOME}/.gitignore" ]] || ln -sfv "$DIR/git/gitignore" "$HOME/.gitignore"

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

# neovim/vim
VIM_DEST_DIR="${HOME}/.config/nvim"
VIM_SRC_DIR="${DIR}/vim"

mkdir -p "${VIM_DEST_DIR}"

for vimfile in ${VIM_SRC_DIR}/*; do
	[[ -L "${VIM_DEST_DIR}/$(basename $vimfile)" ]] && continue
	ln -sfv "$vimfile" "$VIM_DEST_DIR"
done

# Link ~/.vim to nvim's dir.
[[ -L "${HOME}/.vim" ]] || ln -sfv "${VIM_DEST_DIR}" "${HOME}/.vim"

source ~/.zshrc
