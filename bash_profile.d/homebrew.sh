# Configure bash completion of tools installed via Homebrew, and
# a custom git prompt. Requires installing the formula:
#
#   brew install bash-completion
#
# For the git completion and prompt to work, git needs to have been
# installed with hombrew (so it exposes its bash completion script
# in $(brew --prefix)/etc/bash_completion.d). Install it with:
#
#   brew install git
#

if [ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ]; then
    source $(brew --prefix)/etc/profile.d/bash_completion.sh
fi

# Enable git prompt, enable showing unstaged (*) and staged (+) changes
# next to the branch name.
# See: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='[\u@mbp \w$(__git_ps1)]\$ '
