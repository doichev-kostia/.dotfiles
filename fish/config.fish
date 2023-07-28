if status is-interactive
    # Commands to run in interactive sessions can go here
end


# pnpm
set -gx PNPM_HOME "/Users/panenco/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
set -gx PATH "$HOME/.cargo/bin" $PATH;
source ~/.asdf/asdf.fish

source (pack completion --shell fish)






# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/opt/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/opt/google-cloud-sdk/path.fish.inc'; end
