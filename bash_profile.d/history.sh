# Tweak bash's history behaviour.

# Ignore commands that start with spaces, and duplicates.
export HISTCONTROL=ignorespace:ignoredups

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
