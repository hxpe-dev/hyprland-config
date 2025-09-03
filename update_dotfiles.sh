#!/bin/bash

# Set your dotfiles repo path
DOTFILES=~/dotfiles

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 folder1 [folder2 ...]"
    exit 1
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

