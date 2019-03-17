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

# No arguments, select starting commit with fzf.
if [[ "$#" == "0" ]]; then
    HASH=`git log --pretty=oneline | head -n 100 | fzf` && git rebase -i `echo ${HASH} | awk '{ print $1 }'`^
# Single commit and its an integer, rebase starting NUM commits ago
elif [[ "$#" == 1 ]] && [[ "$1" =~ ^[0-9]+$ ]] ; then
    git rebase -i HEAD~$1
# Fallback to git rebase
else
    git rebase "$@"
fi
