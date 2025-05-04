# ~/.bin
mkdir -p "$HOME/.bin"
for binfile in ${DIR}/bin/*; do
	[[ -L "${HOME}/.bin/$(basename $binfile)" ]] && continue
	ln -sfv "$binfile" "$HOME/.bin"
done

# Ghostty
[[ -L "${HOME}/Library/Application Support/com.mitchellh.ghostty/config" ]] || ln -sfv "$DIR/ghostty/config" "${HOME}/Library/Application Support/com.mitchellh.ghostty/config"

# Go
mkdir -p "$HOME/.go"

# zshrc
[[ -L "${HOME}/.zshrc" ]] || ln -sfv "$DIR/zsh/zshrc" "$HOME/.zshrc"

# editorconfig
[[ -L "${HOME}/.editorconfig" ]] || ln -sfv "$DIR/editorconfig/editorconfig" "$HOME/.editorconfig"

# Git
[[ -L "${HOME}/.gitconfig" ]] || ln -sfv "$DIR/git/gitconfig" "$HOME/.gitconfig"
[[ -L "${HOME}/.gitignore" ]] || ln -sfv "$DIR/git/gitignore" "$HOME/.gitignore"
[[ -e "${HOME}/.work.config" ]] || touch "${HOME}/.work.config"

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

# VIM
mkdir -p ~/.config/vim/
for vimfile in ${DIR}/vim/*; do
	[[ -L "${HOME}/.config/vim/$(basename $vimfile)" ]] || ln -sfv "$vimfile" ~/.config/vim/
done

# NVIM
[[ -d ~/.config/nvim ]] || mkdir -p ~/.config/nvim
[[ -L ~/.config/nvim/init.vim ]] || ln -sfv "$DIR/nvim/init.vim" ~/.config/nvim/

source ~/.zshrc
