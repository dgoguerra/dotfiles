#!/usr/bin/env bash

# Wrapper of 'git rebase'.
#
# If no arguments, uses fzf to select the starting commit
# of an interactive rebase.
#
# If single numeric argument, uses it as number of last commits
# for an interactive rebase.
#
# If none of the above, falls back to `git rebase`.
#
# Requires fzf (https://github.com/junegunn/fzf) to be installed:
#
#   brew install fzf
#

if [[ "$#" == "0" ]]; then
    # No arguments, select starting commit with fzf
    LINE=`git log --pretty=oneline | head -n 100 | fzf` || exit 1
    HASH=`echo "$LINE" | awk '{ print $1 }'`
    git rebase -i "$HASH"^
elif [[ "$#" == 1 ]] && [[ "$1" =~ ^[0-9]+$ ]] ; then
    # Single commit and its an integer, rebase starting NUM commits ago
    git rebase -i HEAD~$1
else
    # Fallback to git rebase
    git rebase "$@"
fi
