#!/bin/sh

echo
echo
echo
echo "This script will install some of Morgan's favorite software. It'll be awesome."
echo "If you don't blindly trust him, you may want to edit this script before running it."
echo
echo "For App Store stuff, log in and install them via the Purchases tab."
echo
echo "IMPORTANT: Some of the stuff installed by this script requires Xcode, so"
echo "           be sure to install that before continuing."
echo
echo
read -p "press Enter to begin"
echo
echo

# ========== #

echo "Installing Homebrew ..."

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

# -------

echo "Installing MacVim ..."

brew install macvim
brew linkapps macvim

# -------

echo "Installing cask: iTerm2 ..."

brew cask install --appdir="/Applications" iterm2

# -------

echo "Installing cask: Google Chrome ..."

brew cask install --appdir="/Applications" google-chrome

# -------

echo "Installing cask: Mozilla Firefox ..."

brew cask install --appdir="/Applications" firefox

# -------

echo "Installing cask: Tower ..."

brew cask install --appdir="/Applications" tower

# -------

echo "Installing cask: DiffMerge ..."

brew cask install --appdir="/Applications" diffmerge

# -------

echo "Installing cask: Vagrant ..."

brew cask install --appdir="/Applications" vagrant

# -------

echo "Installing cask: VirtualBox ..."

brew cask install --appdir="/Applications" virtualbox

# -------

echo "Setting up basic user configuration ..."

if [ ! -e ~/.ssh/id_rsa ]; then
	echo "Generating SSH key ..."
	ssh-keygen
	cat ~/.ssh/id_rsa.pub | pbcopy
	echo "Your SSH public key has been copied to the clipboard. Add it to your GitHub account before continuing."
	read -p "press Enter to continue"
fi

if [ ! -d ~/Configs ]; then
	mkdir ~/Configs
fi

# -------

echo "Setting up localstatic/dotfiles ..."

brew tap thoughtbot/formulae
brew install rcm

git clone git@github.com:localstatic/dotfiles.git ~/Configs/dotfiles
if [ ! -e ~/.dotfiles ]; then
	ln -s ~/Configs/dotfiles ~/.dotfiles
fi
rcup -x README.md -x rcrc.template

# -------

echo "Configuring MacVim using localstatic/vimrc ..."

git clone git@github.com:localstatic/vimrc.git ~/Configs/vimrc
~/Configs/vimrc/setup.sh

# -------

echo "Finished."

