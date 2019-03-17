#!/usr/bin/env bash

# Wrapper of 'git checkout'. Uses fzf to select branch
# if no argument was provided.
#
# Requires fzf (https://github.com/junegunn/fzf) to be installed:
#
#   brew install fzf
#

if [[ "$#" == "0" ]]; then
    BRANCH=`git recent-branches | fzf` || exit 1
    git checkout "$BRANCH"
else
    git checkout "$@"
fi
