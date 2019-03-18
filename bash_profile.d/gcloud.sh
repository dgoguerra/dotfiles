# Load Google Cloud SDK.
# See: https://cloud.google.com/sdk/docs/downloads-interactive

# Update PATH
if [ -f "$HOME/Documents/google-cloud-sdk/path.bash.inc" ]; then
    source "$HOME/Documents/google-cloud-sdk/path.bash.inc"
fi

# Enables shell command completion for gcloud.
if [ -f "$HOME/Documents/google-cloud-sdk/completion.bash.inc" ]; then
    source "$HOME/Documents/google-cloud-sdk/completion.bash.inc"
fi
