if [[ ! -e ${DIR}/.git ]] && [[ -e ~/.ssh/id_ed25519 ]]; then
	git clone --quiet --bare https://github.com/jorgeatorres/dotfiles.git ${DIR}/.git
	sed -i '' 's/bare = .*/bare = true/' ${DIR}/.git/config
fi
