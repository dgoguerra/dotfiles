#!/usr/bin/env bash

# Load all profile scripts. This script will run at the start of all shells
# (OSX loads its .bash_profile or equivalent always, not only at the start of
# login shells as standard).

for file in "$DOTFILES_ROOT"/profiles/*; do
    source "$file";
done
