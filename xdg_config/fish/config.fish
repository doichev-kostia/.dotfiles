# enable vim
fish_vi_key_bindings

set -x EDITOR "nvim"

ssh-add --apple-load-keychain 2>/dev/null
# ssh-add --apple-use-keychain ~/.ssh/github_personal
# ssh-add --apple-use-keychain ~/.ssh/github

# LLVM
fish_add_path /opt/homebrew/opt/llvm/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# JetBrains
set -x PATH "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" $PATH

# Brew
set -x HOMEBREW_NO_AUTO_UPDATE true

# Make
set -x PATH "/opt/homebrew/opt/make/libexec/gnubin" $PATH

# pnpm
set -gx PNPM_HOME "/Users/doichevkostia/Library/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end

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

# starship
if command -q starship
  starship init fish | source
end


# odin
set --export PATH "/usr/local/opt/odin" $PATH
set --export PATH "/opt/odin" $PATH
# roc
set --export PATH "/opt/roc/zig-out/bin" $PATH

set --export GPG_TTY (tty)

# Rust
#if test -d "$HOME/.cargo/"
#  sudo chown -R $(whoami) "$HOME/.cargo/"
#end

# sccache disabled: conflicts with cargo incremental builds and its cache was too small
# for the stxr monorepo (~1% hit rate). Re-enable per-project if doing cold/CI builds.
# set -x RUSTC_WRAPPER sccache


if command -q lazygit
  alias lg="lazygit"
end

# uv
fish_add_path "$HOME/.local/bin"

# opencode
fish_add_path /Users/doichevkostia/.opencode/bin

fish_add_path -a "/Users/doichevkostia/.foundry/bin"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/doichevkostia/.opam/opam-init/init.fish' && source '/Users/doichevkostia/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
~/.local/bin/mise activate fish | source
