# Downloads
open https://brave.com/download/
open https://qsapp.com/download.php
open https://bahoom.com/hyperswitch
open https://pqrs.org/osx/karabiner/
open https://clipy-app.com/

# Installation
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

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
