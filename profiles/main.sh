# Aliases
# --------------------------------

# Find your external IP address. See: http://unix.stackexchange.com/a/81699
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'

# Find your internal IP address. See: http://stackoverflow.com/a/13322549
alias lanip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"

# List repositories dir ordered by access time,
# select one with fzf and cd into it.
alias c='DIR="$(ls -tu ~/code | fzf)" && cd ~/code/"$DIR"'

# Environment
# --------------------------------

# Add this repo's binaries to the PATH.
export PATH="${PATH}:${DOTFILES_ROOT}/bins"

# Bash history
# --------------------------------

# Ignore commands that start with spaces, and duplicates.
#export HISTCONTROL=ignorespace:ignoredups

# When the shell exits, append to the history file instead of overwriting it
#shopt -s histappend

# Increase history file size and number of commands saved
#export HISTSIZE=100000
#export HISTFILESIZE=100000

# Homebrew
# --------------------------------

if type brew &>/dev/null; then
    BREW_PREFIX=$(brew --prefix)

    # Enable completion of commands installed with Homebrew. Requires
    # installing the formula:
    #
    #   brew install zsh-completions
    #
    # To avoid the error "zsh compinit: insecure directories", run:
    #
    #   chmod -R go-w "$(brew --prefix)/share"
    #
    # See: https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh

    #FPATH="${BREW_PREFIX}/share/zsh/site-functions:${FPATH}"
    #FPATH=${BREW_PREFIX}/share/zsh-completions:$FPATH
    #autoload -Uz compinit
    #compinit

    # Enable git prompt, enable showing unstaged (*) and staged (+) changes
    # next to the branch name.
    #
    # Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
    # ZSH:  setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
    #
    # See: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
    if [[ -f "${BREW_PREFIX}/etc/bash_completion.d/git-prompt.sh" ]]; then
        source "${BREW_PREFIX}/etc/bash_completion.d/git-prompt.sh"
        GIT_PS1_SHOWDIRTYSTATE=true
        # #PS1='[\u@\h \w$(__git_ps1)]\$ '
        setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
    fi
fi

