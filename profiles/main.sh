# Aliases
# --------------------------------

# Find your external IP address. See: http://unix.stackexchange.com/a/81699
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'

# Find your internal IP address. See: http://stackoverflow.com/a/13322549
alias lanip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"

# Force syncing known bluetooth devices "Diego's Trackpad" and "Diego's Keyboard".
# Requires installing blueutil: "brew install blueutil".
alias bluesync="blueutil --connect 8c-85-90-f3-9b-b8 && blueutil --connect c0-a5-3e-09-07-c7"

# Silver Searcher with default pager.
# See: https://github.com/ggreer/the_silver_searcher
# Install with "brew install the_silver_searcher"
alias ag="ag --pager 'less -SR'"

# List repositories dir ordered by access time,
# select one with fzf and cd into it.
alias c='DIR="$(ls -tu ~/code | fzf)" && cd ~/code/"$DIR"'

# List all directories in a dir, select one with fzf
# and cd into it.
cdf() {
  local DIR
  DIR=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print | fzf) && cd "$DIR"
}

alias d=docker
alias k=kubectl

# Environment
# --------------------------------

# Add composer global binaries to the PATH.
export PATH="$PATH:$HOME/.composer/vendor/bin"

# Add Python binaries to the PATH.
export PATH="$PATH:$HOME/Library/Python/3.7/bin"

# Disable Ansible cowsay easter egg. See: https://github.com/ansible/ansible/issues/10530
export ANSIBLE_NOCOWS=1

# Bash history
# --------------------------------

# Ignore commands that start with spaces, and duplicates.
export HISTCONTROL=ignorespace:ignoredups

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# Increase history file size and number of commands saved
export HISTSIZE=100000
export HISTFILESIZE=100000

# NodeJS
# --------------------------------

# Increase default NodeJS memory to 4GB (instead of default 512MB).
export NODE_OPTIONS="--max_old_space_size=4096"

# Setup NVM (Node Version Manager).
# See: https://github.com/creationix/nvm
if [ -s "$HOME/.nvm/nvm.sh" ]; then
    source "$HOME/.nvm/nvm.sh"
fi
# if [ -s "$HOME/.nvm/bash_completion" ]; then
#     source "$HOME/.nvm/bash_completion"
# fi

# Google Cloud SDK
# --------------------------------
#
# See: https://cloud.google.com/sdk/docs/downloads-interactive

# Update PATH
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then
    source "$HOME/google-cloud-sdk/path.bash.inc"
fi

# Enable shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then
    source "$HOME/google-cloud-sdk/completion.bash.inc"
fi

# Homebrew
# --------------------------------
#
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

if type brew &>/dev/null; then
    BREW_PREFIX=$(brew --prefix)
    for COMPLETION in $BREW_PREFIX/etc/bash_completion.d/*; do
        [[ -f $COMPLETION ]] && source "$COMPLETION"
    done
    if [[ -f $BREW_PREFIX/etc/profile.d/bash_completion.sh ]]; then
        source "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
    fi
fi

# Enable git prompt, enable showing unstaged (*) and staged (+) changes
# next to the branch name.
# See: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
PS1='[\u@mbp \w$(__git_ps1)]\$ '
