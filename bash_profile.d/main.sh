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

# Environment
# --------------------------------

# Add composer global binaries to the PATH.
export PATH="$PATH:$HOME/.composer/vendor/bin"

# Disable Ansible cowsay easter egg. See: https://github.com/ansible/ansible/issues/10530
export ANSIBLE_NOCOWS=1
