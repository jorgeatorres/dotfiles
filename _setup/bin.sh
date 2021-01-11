mkdir -p "$HOME/bin"

maybe_link "$DIR/bin/brew-update" "$HOME/bin/brew-update"
maybe_link "$DIR/bin/git-move-repo" "$HOME/bin/git-move-repo"
maybe_link "$DIR/bin/git-remove-branch" "$HOME/bin/git-remove-branch"
maybe_link "$DIR/bin/git-remove-tag" "$HOME/bin/git-remove-tag"
maybe_link "$DIR/bin/git-rename-tag" "$HOME/bin/git-rename-tag"
maybe_link "$DIR/bin/online-radio" "$HOME/bin/online-radio"
maybe_link "$DIR/bin/pdf-reduce-size" "$HOME/bin/pdf-reduce-size"


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
