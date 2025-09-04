#!/bin/bash

# Set your dotfiles repo path
DOTFILES=~/dotfiles

# If no arguments, update all existing folders in dotfiles
if [ $# -eq 0 ]; then
    echo "No folders specified. Updating all existing folders in $DOTFILES..."
    set -- $(ls -1 "$DOTFILES")
fi

for folder in "$@"; do
    SRC="$HOME/.config/$folder"
    DEST="$DOTFILES/$folder"

    # Check if the source folder exists
    if [ ! -d "$SRC" ]; then
        echo "Folder $SRC does not exist. Skipping."
        continue
    fi

    # Remove old copy if it exists
    if [ -d "$DEST" ]; then
        echo "Removing old copy of $folder in dotfiles..."
        rm -rf "$DEST"
    fi

    # Copy the folder
    echo "Copying $folder to dotfiles..."
    cp -r "$SRC" "$DEST"
done

echo "Done."

