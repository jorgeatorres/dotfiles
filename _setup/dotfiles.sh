# zshrc
maybe_link "$DIR/zsh/zshrc" "$HOME/.zshrc"

# editorconfig
maybe_link "$DIR/editorconfig/editorconfig" "$HOME/.editorconfig"

# git
maybe_link "$DIR/git/gitconfig" "$HOME/.gitconfig"
maybe_link "$DIR/git/gitconfig.work" "$HOME/.gitconfig.work"
maybe_link "$DIR/git/gitignore" "$HOME/.gitignore"

# nano
maybe_link "$DIR/nano/nanorc" "$HOME/.nanorc"

# vim
maybe_link "$DIR/vim/vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.vim"
maybe_link "$DIR/vim/gvimrc" "$HOME/.vim/gvimrc"

source ~/.zshrc
