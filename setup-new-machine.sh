echo "Installing homebrew"
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing brews"
# xargs brew tap < taps-list.txt
# xargs brew install < brew-list.txt

echo "Installing casks"
# TODO setup taps
# xargs brew cask install < cask-list.txt

echo "Setuping up brew services"
# xargs brew cask install < services-list.txt

# TODO install python
# TODO install neovim via python
# TODO install python deps
# TODO set pip only

echo "Changing shell"
#chsh -s /usr/local/bin/fish

echo "Installing neobundle"
# curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

echo "Setuping up dotfiles"
#sh symlink-setup.sh

echo "Setting iterm2 preferences"
# TODO should set location of dotfiles first
defaults import $(pwd)/com.googlecode.iterm2.plist

echo "Installing fonts"
cp fonts/*.ttf /Library/Fonts

echo "Updating macos settings"
# sh macos.sh

# TODO: crontab
