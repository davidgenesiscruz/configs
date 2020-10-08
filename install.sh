# Downloads
open https://www.google.com/chrome/
open https://www.mozilla.org/en-US/firefox/developer/
open https://qsapp.com/download.php
open https://bahoom.com/hyperswitch
open https://developer.apple.com/xcode/
open https://pqrs.org/osx/karabiner/
open https://store.docker.com/editions/community/docker-ce-desktop-mac
open https://clipy-app.com/

# Installations
## Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Python
brew install python
cd /usr/local/bin
ln -s python3 python
python --version

## Tmux
brew install tmux

## dein.vim
mkdir -p ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
rm ./installer.sh

## neovim
pip3 install neovim

## reconfigure vim
brew remove vim
brew cleanup
brew install vim

## gcalcli
git clone https://github.com/insanum/gcalcli.git
cd gcalcli
python setup.py install
cd ..
rm -rf gcalcli

## imagemagick
brew install imagemagick

# Instructions
echo 'Modify KeySetting_Default.plist within /System/Library/Input Methods/JapaneseIM.app for space and half-width space'
