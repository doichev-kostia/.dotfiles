# enable vim 
fish_vi_key_bindings


if status is-interactive
    # Commands to run in interactive sessions can go here
end


# pnpm
set -gx PNPM_HOME "/Users/panenco/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
#cargo
set -gx PATH "$HOME/.cargo/bin" $PATH;

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/opt/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/opt/google-cloud-sdk/path.fish.inc'; end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

direnv hook fish | source
set -g direnv_fish_mode eval_on_arrow

# go
set --export GOBIN "$HOME/go/bin"
set --export PATH $GOBIN $PATH

# dotnet
complete -f -c dotnet -a "(dotnet complete (commandline -cp))"

# nix
set --export PATH "/run/current-system/sw/bin" $PATH

# starship
starship init fish | source

uvx --generate-shell-completion fish | source

# odin
set --export PATH "/usr/local/opt/odin" $PATH


# uv
fish_add_path "/Users/panenco/.local/bin"

set --export GPG_TTY (tty)
