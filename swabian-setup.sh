#!/bin/sh
if !(type "brew" > /dev/null 2>&1); then
    while :
    do
        echo "Homebrew have not been installed in your device,"
        read -p "and will be installed. Proceed? [y/n]: " -n 1 yn
        case $yn in
            [Yy]* ) break;;
            [NnQq]* )
            echo "\nInstall cancelled."
            exit;;
            * ) echo "\nPlease answer y or n.";;
        esac
    done
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Following software will be installed."
echo "- docker\n- xquartz\n- virtualbox\n- virtualbox-extension-pack"

brew update
brew cask install docker
brew cask install virtualbox
brew cask install virtualbox-extension-pack
