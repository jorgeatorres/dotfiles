# Some other scripts stored in an outside repo because of work/secrets.
if [[ ! -d "$DIR/private.git" ]]; then
	git clone git@github.com:jorgeatorres/dotfiles-private.git "$DIR/private.git" --quiet;
fi

source "$DIR/private.git/setup.sh"
