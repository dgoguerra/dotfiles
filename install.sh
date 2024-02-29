#!/usr/bin/env bash

set -e

# Current file's dir
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_profile_loader() {
    # Load dotfiles through .zshrc in OSX, .bashrc in Linux
    if [[ "$OSTYPE" == "darwin"* ]]; then
        local profile="$HOME/.zshrc"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        local profile="$HOME/.bashrc"
    else
        echo >&2 "Error: unsupported platform '$OSTYPE', loader will not be installed."
        exit 1
    fi

    if [ ! -f "$profile" ]; then
        echo >&2 "Error: '$profile' not found, loader will not be installed."
        exit 1
    fi

    if grep -qc 'dgoguerra/dotfiles' "$profile"; then
        echo "Loader already exists in '$profile', doing nothing."
    else
        echo "" >> "$profile"
        echo "# Install dgoguerra/dotfiles profile loader" >> "$profile"
        echo "export DOTFILES_ROOT=$BASEDIR" >> "$profile"
        echo "[[ -s \"\$DOTFILES_ROOT/loader.sh\" ]] && source \"\$DOTFILES_ROOT/loader.sh\"" >> "$profile"

        echo "Installed profile loader in '$profile'."
    fi
}

symlink() {
    local source="$1"
    local dest="$2"

    if [ -L "$dest" ]; then
        local current_link="$(readlink $dest)"

        # Symlink already exists, check if it points to the correct file
        if [ "$current_link" = "$source" ]; then
            echo "$dest => $source (already exists)"
        else
            echo >&2 "Error: '$dest' already links to '$current_link', remove it first to symlink."
        fi
    elif [ -f "$dest" ]; then
        echo >&2 "Error: '$dest' already exists, remove it first to symlink."
    else
        ln -s "$source" "$dest"
        echo "$dest => $source"
    fi
}

# Install bash_profile scripts loader in the user's .zshrc
install_profile_loader

# Symlink all dotfiles. Notice that all dotfiles are missing
# the leading dot, which is added when symlinking them to the
# user's home.
echo
echo "Linking dotfiles:"
for file in "$BASEDIR"/dotfiles/*; do
    symlink "$file" ~/.$(basename "$file")
done
