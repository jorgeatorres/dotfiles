# Some other scripts stored in an outside repo because of work/secrets.
if [[ ! -d "$DIR/bin-private.git" ]]; then
	git clone git@github.com:jorgeatorres/bin.git "$DIR/bin-private.git" --quiet;
fi

if [[ -d "$DIR/bin-private.git" ]]; then
	maybe_link "$DIR/bin-private.git/a8c.sh" "$HOME/bin/a8c-proxy"
	maybe_link "$DIR/bin-private.git/nike-training.rb" "$HOME/bin/nike-training"
	maybe_link "$DIR/bin-private.git/dayone-sync.py" "$HOME/bin/dayone-sync"
	maybe_link "$DIR/bin-private.git/woo.php" "$HOME/bin/woo"
fi
