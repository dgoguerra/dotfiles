#!/usr/bin/env bash

# Current file's dir
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_profile_loader() {
    local profile="$HOME/.bash_profile"

    if [ -z "$profile" ]; then
        echo >&2 "Error: '$profile' not found, loader will not be installed."
    fi

    if grep -qc 'dgoguerra/dotfiles' "$profile"; then
        echo "Loader already exists in '$profile', doing nothing."
    else
        echo "" >> "$profile"
        echo "# Install dgoguerra/dotfiles profile loader" >> "$profile"
        echo "export DOTFILES_DIR=$BASEDIR" >> "$profile"
        echo "[[ -s \"\$DOTFILES_DIR/loader.sh\" ]] && . \"\$DOTFILES_DIR/loader.sh\"" >> "$profile"

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

# Install bash_profile scripts loader in the user's .bash_profile.
install_profile_loader

# Symlink all dotfiles. Notice that all dotfiles are missing
# the leading dot, which is added when symlinking them to the
# user's home.
echo
echo "Linking dotfiles:"
for file in "$BASEDIR"/dotfiles/*; do
    symlink "$file" ~/.$(basename "$file")
done

# Symlink all binaries.
echo
echo "Linking binaries:"
for file in "$BASEDIR"/bins/*; do
    symlink "$file" /usr/local/bin/$(basename "$file")
done

# OSX: install brew dependencies and set custom system config.
echo
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Configuring OSX settings. You may be asked to enter your sudo password."
    source "$BASEDIR/scripts/osx-config.sh"

    echo "Installing OSX dependencies."
    source "$BASEDIR/scripts/osx-deps.sh"
else
    echo "System is not OSX, skipping OSX specific configuration."
fi


# Install NPM dependencies.
echo
echo "Installing NPM dependencies."
source "$BASEDIR/scripts/npm-deps.sh"
