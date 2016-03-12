#!/bin/sh

BUNDLE_DIR="$HOME/.vim/bundle"
VIM_DIR="$HOME/.vim"

INSTALL_ALL=false

if [ -d $BUNDLE_DIR ]; then
        echo "Warning!!! There are some plugins installed already."
        echo "If you want to continue then old plugins will be erased."
        read -r -p "Do you want to continue? (y/N) " RESPONSE
        case $RESPONSE in
                [yY][eE][sS]|[yY])
                        ;;
                *)
                        echo "Exit then..."
                        exit 0
                        ;;
        esac
fi

cd $VIM_DIR

echo "Creating backup directories..."
rm -rf backup
mkdir -p backup/backup
mkdir -p backup/swap
mkdir -p backup/undo

echo "Installing..."

rm -rf bundle
mkdir -p bundle

git clone https://github.com/Valloric/YouCompleteMe.git bundle/youcompleteme
cd $BUNDLE_DIR/youcompleteme
git submodule update --init --recursive
./install.py --clang-completer

