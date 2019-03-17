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
        echo "[[ -s \"$BASEDIR/loader.sh\" ]] && . \"$BASEDIR/loader.sh\"" >> "$profile"

        echo "Installed profile loader in '$profile'."
    fi
}

symlink_dotfile() {
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

install_profile_loader

# Symlink all found dotfiles. Notice that all dotfiles are missing
# the leading dot, which is added when symlinking them to the
# user's home.
echo "Setting symlinks:"
for file in "$BASEDIR"/dotfile.d/*; do
    symlink_dotfile "$file" ~/.$(basename "$file")
done
