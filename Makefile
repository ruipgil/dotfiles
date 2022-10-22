DOTFILES_FOLDER=-d ~/dotfiles
BREW_FILE_LOCATION=./Brewfile
BREW_BUNDLE_FILE=--file ${BREW_FILE_LOCATION}
IGNORE_FOLDERS=-x raycast -x README.md -x Brewfile -x Makefile -x packer_compiled.lua

dry-run:
	lsrc ${DOTFILES_FOLDER} ${IGNORE_FOLDERS}

setup-dotfiles:
	rcup -v ${DOTFILES_FOLDER} ${IGNORE_FOLDERS}

# Homebrew
to-brewfile:
	rm Brewfile
	brew bundle dump ${BREW_BUNDLE_FILE}

from-brewfile:
	brew bundle cleanup ${BREW_BUNDLE_FILE}
	brew bundle install ${BREW_BUNDLE_FILE}

is-brew-in-sync:
	brew bundle check ${BREW_BUNDLE_FILE}
