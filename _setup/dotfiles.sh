# ~/.bin
mkdir -p "$HOME/.bin"

# Remove stale links pointing to repo scripts that no longer exist.
for binlink in ${HOME}/.bin/*; do
	[[ -L "$binlink" && "$(readlink "$binlink")" == ${DIR}/bin/* && ! -e "$binlink" ]] && rm -v "$binlink"
done

for binfile in ${DIR}/bin/*; do
	[[ -L "${HOME}/.bin/$(basename $binfile)" ]] && continue
	ln -sfv "$binfile" "$HOME/.bin"
done

# Ghostty
mkdir -p "${HOME}/Library/Application Support/com.mitchellh.ghostty/"
[[ -L "${HOME}/Library/Application Support/com.mitchellh.ghostty/config" ]] || ln -sfv "$DIR/ghostty/config" "${HOME}/Library/Application Support/com.mitchellh.ghostty/config"

# Go
mkdir -p "$HOME/.go"

# zshrc
[[ -L "${HOME}/.zshrc" ]] || ln -sfv "$DIR/zsh/zshrc" "$HOME/.zshrc"

# editorconfig
[[ -L "${HOME}/.editorconfig" ]] || ln -sfv "$DIR/editorconfig/editorconfig" "$HOME/.editorconfig"

# Git
mkdir -p ${HOME}/.config/git
[[ -L "${HOME}/.config/git/config" ]] || ln -sfv "$DIR/git/gitconfig" "$HOME/.config/git/config"
[[ -L "${HOME}/.config/git/gitignore" ]] || ln -sfv "$DIR/git/gitignore" "$HOME/.config/git/gitignore"
[[ -e "${HOME}/.config/git/config-work" ]] || touch "${HOME}/.config/git/config-work"

if [[ ! -e "$HOME/.config/git/config-personal" ]]; then
	require_1password

	EMAIL_ADDRESS=$(get_email_address)

	GIT_FULL_NAME=$(id -F)
	GITHUB_USER=$(op read "op://Private/h4o7gzk4lbdmlikj56ivaf7y3a/Username")

	cat <<EOF > "$HOME/.config/git/config-personal"
[user]
	name = $GIT_FULL_NAME
	email = $EMAIL_ADDRESS
[github]
	user = $GITHUB_USER
EOF
fi

# VIM
mkdir -p ~/.config/vim/
[[ -L "${HOME}/.config/vim/vimrc" ]] || ln -sfv "$DIR/vim/vimrc" ~/.config/vim/
[[ -L "${HOME}/.config/vim/gvimrc" ]] || ln -sfv "$DIR/vim/gvimrc" ~/.config/vim/

# NVIM
[[ -d ~/.config/nvim ]] || mkdir -p ~/.config/nvim

for nvimfile in ${DIR}/nvim/*.vim; do
	[[ -L "${HOME}/.config/nvim/$(basename $nvimfile)" ]] || ln -sfv "$nvimfile" ~/.config/nvim/
done

source ~/.zshrc
