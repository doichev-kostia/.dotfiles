# enable vim
fish_vi_key_bindings

ssh-add --apple-load-keychain 2>/dev/null
# ssh-add --apple-use-keychain ~/.ssh/github_personal
# ssh-add --apple-use-keychain ~/.ssh/github


if status is-interactive
    # Commands to run in interactive sessions can go here
end

# JetBrains
set -x PATH "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" $PATH

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# deno
set -gx PATH "$HOME/.deno/bin" $PATH;

#cargo
set -gx PATH "$HOME/.cargo/bin" $PATH;

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/opt/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/opt/google-cloud-sdk/path.fish.inc'; end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

if command -q direnv
  direnv hook fish | source
  set -g direnv_fish_mode eval_on_arrow
end

# go
set --export PATH "/usr/local/go/bin" $PATH
set --export GOBIN "$HOME/go/bin"
set --export PATH $GOBIN $PATH

# dotnet
if command -q dotnet
    complete -f -c dotnet -a "(dotnet complete (commandline -cp))"
end

# nix
# set --export PATH "/run/current-system/sw/bin" $PATH

# starship
if command -q starship
  starship init fish | source
end


# odin
set --export PATH "/usr/local/opt/odin" $PATH
set --export PATH "/opt/odin" $PATH


# uv
fish_add_path "/Users/panenco/.local/bin"
if command -q uvx
  uvx --generate-shell-completion fish | source
end

set --export GPG_TTY (tty)

# Rust
#if test -d "$HOME/.cargo/"
#  sudo chown -R $(whoami) "$HOME/.cargo/"
#end

if command -q lazygit
  alias lg="lazygit"
end

# uv
fish_add_path "$HOME/.local/bin"

# solana
fish_add_path "$HOME/.local/share/solana/install/active_release/bin"

# avm
fish_add_path "$HOME/.avm/bin"

#ghidra for reverse engineering
set --export PATH "/opt/ghidra" $PATH

fish_add_path "$HOME/.nimble/bin"
