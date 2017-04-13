brew tap > lists/taps.txt
brew cask list > lists/cask.txt
brew leaves > lists/brew.txt
brew services list | awk '{print $1}' | tail -n +2 > lists/services.txt

