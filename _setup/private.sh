# Some other scripts stored in an outside repo because of work/secrets.
if [[ ! -d "$DIR/dotfiles-private.git" ]]; then
	git clone git@github.com:jorgeatorres/dotfiles-private.git "$DIR/private.git" --quiet;
fi

if [[ -d "$DIR/private.git" ]]; then
	source "$DIR/private.git/setup.sh"
fi
