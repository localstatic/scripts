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

echo "Installing Composer ..."

curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin

# -------

echo "Installing Homebrew ..."

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

# -------

echo "Installing from Homebrew: The Silver Searcher (ag) ..."

brew install the_silver_searcher

# -------

echo "Installing from Homebrew: Git ..."

brew install git

# -------

echo "Installing from Homebrew: Bash Completion ..."

brew install bash-completion

# -------

echo "Installing from Homebrew Cask: MacVim ..."

brew cask install macvim

# -------

echo "Installing from Homebrew Cask: iTerm2 ..."

brew cask install iterm2

# -------

echo "Installing from Homebrew Cask: Google Chrome ..."

brew cask install google-chrome

# -------

echo "Installing from Homebrew Cask: Mozilla Firefox ..."

brew cask install firefox

# -------

echo "Installing from Homebrew Cask: Flash plugin ..."

brew cask install flash

# -------

echo "Installing from Homebrew Cask: Tower ..."

brew cask install tower

# -------

echo "Installing from Homebrew Cask: DiffMerge ..."

brew cask install diffmerge

# -------

echo "Installing from Homebrew Cask: Vagrant ..."

brew cask install vagrant

# -------

echo "Installing from Homebrew Cask: Vagrant Manager ..."

brew cask install vagrant-manager

# -------

echo "Installing from Homebrew Cask: VirtualBox ..."

brew cask install virtualbox

# -------

echo "Installing NPM ..."

brew install npm

# -------

echo "Installing from NPM: JSON Lint ..."

npm install --global jsonlint

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

echo "Installing Composer package: PHP CodeSniffer"

composer global require "squizlabs/php_codesniffer=*"

# -------

echo "Finished."

