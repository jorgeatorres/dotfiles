# Inspired by https://github.com/ttaylorr/dotfiles/blob/work-gh/Makefile
DOTFILES := $(shell pwd)

all: bash bin editorconfig git homebrew nano vim
.PHONY: bash bin editorconfig git homebrew nano vim

bash:
	ln -sf $(DOTFILES)/bash/bashrc ${HOME}/.bashrc
	ln -sf $(DOTFILES)/bash/profile ${HOME}/.profile

bin:
	[ ! -h ${HOME}/.bin ] && ln -sf $(DOTFILES)/bin ${HOME}/.bin || true

editorconfig:
	ln -sf $(DOTFILES)/editorconfig/editorconfig ${HOME}/.editorconfig

git:
	ln -sf $(DOTFILES)/git/gitconfig ${HOME}/.gitconfig
	ln -sf $(DOTFILES)/git/gitignore ${HOME}/.gitignore

homebrew:
	ln -sf $(DOTFILES)/homebrew/Brewfile ${HOME}/.Brewfile
	brew bundle --global

nano:
	ln -sf $(DOTFILES)/nano/nanorc ${HOME}/.nanorc

vim:
	$(call install-if-missing, "vim")	
	[ ! -L ${HOME}/.vim ] && ln -Ffs $(DOTFILES)/vim/ ${HOME}/.vim || true
	ln -sf $(DOTFILES)/vim/vimrc ${HOME}/.vimrc
	ln -sf $(DOTFILES)/vim/gvimrc ${HOME}/.gvimrc


define install-if-missing
	@brew list $1 > /dev/null 2>&1 || brew install $1
endef