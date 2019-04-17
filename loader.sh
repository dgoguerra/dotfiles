#!/usr/bin/env bash

# Load all bash_profile scripts. This script will run at the
# start of all shells (since OSX loads .bash_profile always,
# not only at the start of login shells as standard).

# Current file directory
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for file in "$BASEDIR"/profiles/*; do
    source "$file";
done
