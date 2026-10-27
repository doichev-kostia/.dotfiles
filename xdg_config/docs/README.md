# Machine setup

What is installed and configured on this Mac beyond the defaults, and why. Agents (Claude Code,
Codex, opencode) read this through their global instruction files, so it is the one place to look
before changing tooling.

Rules for keeping it useful:

- Paths are written with `~` or `$HOME`, never the account name.
- When you change machine-level config (a hook, a global tool, a launch agent, a shell file), update
  the matching section and add a line to the [change log](#change-log).
- No secrets, tokens, emails or account names in this file.

## Where things live

| What | Where |
|---|---|
| Dotfiles repo (versioned) | `~/.dotfiles` — `xdg_config/*` is symlinked into `~/.config/` |
| This doc | `~/.dotfiles/xdg_config/docs/README.md`, read as `~/.config/docs/README.md` |
| Homebrew list | `~/.dotfiles/Brewfile` (out of date, see [Homebrew](#homebrew)) |
| Global mise tools | `~/.config/mise/config.toml` (not in the dotfiles repo) |
| Cargo config | `~/.cargo/config.toml` (not in the dotfiles repo) |
| Claude Code | `~/.claude/` |
| Codex | `~/.codex/` |
| Skills shared by agents | `~/.agents/skills/` |
| User launch agents | `~/Library/LaunchAgents/` |

## Shells and terminal

- Login shell: **fish** (`/opt/homebrew/bin/fish`), config in `~/.config/fish` (dotfiles).
- Terminal: **Ghostty**; multiplexer: **zellij**. tmux is installed but not used.
- Prompt: starship. Window manager: AeroSpace.
- **Agent shells are zsh, not fish.** The Claude Code Bash tool runs zsh and reads `~/.zshrc`
  (zsh completions and Solana on PATH). That file is a plain file in `$HOME`, not the
  `.zshrc` kept in the dotfiles repo.

## Homebrew

`~/.dotfiles/Brewfile` is the list, with a comment on why each tool is there. Entries at the end
under "Installed but missing from this file until 2026-10-27" were appended from a dump and have
no comments yet.

To find drift, compare against a dump instead of overwriting the file (a dump drops the
comments):

```sh
brew bundle dump --file=/tmp/Brewfile.dump --force --no-vscode --no-go --no-cargo --no-uv --no-npm
```

`brew bundle check` also fails when a listed package is only outdated; `--verbose` shows which.

## mise (global tools)

`~/.config/mise/config.toml`:

```toml
wrappers = { cargo = { command = "mbx", env = { MBX_CARGO_SHIM_MODE = "1" } } }
[tools]
just = "latest"
mr-boxington = "latest"          # mbx, the shared cargo compile cache
rust = { version = "latest", mr_boxington = true }
shfmt = "latest"                 # bash parser used by the Claude polling hook
```

The `wrappers` line makes every `cargo` call go through mbx. Projects pin their own versions in
their own `mise.toml` (the stxr workspace pins Rust through `rust-toolchain.toml`).

Other version managers: rustup (toolchains 1.95.0, 1.97.1 default, 1.99.0, stable, a dated
nightly), Node through mise shims, uv and poetry for Python. No deno, fnm or mongosh (removed
2026-10-27).

## Rust builds

- **mbx (mr-boxington)** caches compiled crates across checkouts, worktrees and `/tmp` copies.
  Cache in `~/Library/Caches/mbx`, 45 GiB budget, automatic gc.
  - `mbx stats`: lifetime savings.
  - `mbx explain --last`: why the last build missed or skipped the cache.
  - `mbx doctor`: setup check.
  - Skill: `~/.claude/skills/mbx` and `~/.codex/skills/mbx`, both linked to the copy shipped with
    the installed mbx.
- **`~/.cargo/config.toml`**: mold for Linux x86-64, rust-lld for Windows, Apple's default linker
  on macOS. rust-lld was dropped on macOS on 2026-10-27. It relinked no faster, and mbx before 1.28
  could not cache any crate built with `-C linker=...`, so 30 days of builds got almost no cache
  hits. sccache was removed earlier: it cannot cache incremental builds.
- After changing linker, rustflags or profiles, run a build and check `mbx explain --last` for
  `unknown-codegen-option` or other skip reasons.

## AI agents

### Claude Code (`~/.claude/`)

- `settings.json`: auto permission mode, model opus, high effort, fullscreen UI, light theme.
  Plugins: ralphex, chrome-devtools-mcp. A pre-change backup sits in `settings.json.bak`.
- `CLAUDE.md` contains only `@RTK.md` plus the pointer to this doc.
- Hooks:

  | Event | Command | Purpose |
  |---|---|---|
  | SessionStart | `~/.claude/hooks/herdr-agent-state.sh session` | herdr agent-state integration; managed by herdr, do not edit |
  | PreToolUse (Bash) | `python3 -I ~/.claude/hooks/no-foreground-polling.py` | Refuses foreground polling loops on the main conversation thread |
  | PreToolUse (Bash) | `rtk hook claude` | Rewrites shell commands through rtk to shrink their output |

- **Polling hook**: parses the command with shfmt and refuses it when a `while`, `until` or `for`
  loop sleeps in its body, unless the call is backgrounded (`run_in_background`), comes from a
  subagent (the hook input has `agent_id`), or is a `for` loop whose total wait is known and at
  most 30 s. Unparseable commands pass. Refusals are logged to
  `~/.claude/hooks/no-foreground-polling.log`; check it for wrong refusals.
- **rtk** (Rust Token Killer, Homebrew): filters command output before the agent sees it.
  `rtk gain` shows savings, `rtk discover` finds missed ones, `rtk proxy <cmd>` runs a command
  unfiltered. Installed with `rtk init -g`; `rtk init -g --uninstall` removes it.
- Skills in `~/.claude/skills/`: `decision-log` (→ `~/.agents/skills`), `fffq` (→ the fffq repo),
  `mbx` (→ mise install), `synced/` (from claude.ai, managed by Claude Code).
- Per-project memory: `~/.claude/projects/<project>/memory/`.

### Codex (`~/.codex/`)

- `config.toml`: model, reasoning effort, trusted project paths.
- `AGENTS.md` includes `RTK.md`, which tells Codex to prefix commands with `rtk` (Codex has no
  rewrite hook).
- `hooks.json`: SessionStart runs herdr's `~/.codex/herdr-agent-state.sh`.
- Skills: `~/.codex/skills/mbx` (link), plus the built-in `.system` skills.

### Shared

- `~/.agents/skills/`: ast-grep, codebase-explorer, decision-log, linear-progress-management.
- opencode config in `~/.config/opencode/`.
- **fffq** code search: the `fffd` daemon runs as a launch agent and serves Claude Code, opencode
  and Paseo.

## Background services (launch agents)

User agents in `~/Library/LaunchAgents/`:

| Label (account part shown as `<user>`) | Runs |
|---|---|
| `io.fffq.fffd` | `~/.local/bin/fffd`, the fffq search daemon |
| `com.<user>.hourly-check-in` | `~/.local/bin/hourly-check-in` |
| `dev.<user>.finance.backup` | `~/Library/Application Support/finance-backup/run.sh` |
| `ai.openclaw.gateway` | openclaw gateway; **broken**, it points at a Node under `~/.local/share/fnm`, which no longer exists |
| `com.github.facebook.watchman` | watchman |
| Google updater / keystone, JetBrains Toolbox | vendor updaters |

`launchctl list | grep <label>` shows status. `launchctl kickstart -k gui/$(id -u)/<label>`
restarts one.

## Git and SSH

- `~/.gitconfig`: delta pager, nvim editor, rerere, `push.autoSetupRemote`, git-lfs, no commit
  signing. `gh` is the credential helper for github.com.
- Identities switch by directory with `includeIf`: `~/work/` uses `~/work/.gitconfig`;
  `~/personal/` and `~/.dotfiles/` use `~/personal/.gitconfig`.
- SSH host aliases in `~/.ssh/config`: `github.com` and `github-work` (work account),
  `github-personal` (personal repos, including the dotfiles repo), `linode_playground`.
- Global gitignore: `~/.dotfiles/.global.gitignore`.

## Change log

- 2026-10-27: mbx 1.13 → 1.28. rust-lld removed from the macOS targets in `~/.cargo/config.toml`
  (and from the stxr workspace's `.cargo/config.toml`, including its `-A linker_messages`
  rustflags).
- 2026-10-27: mbx skill linked into `~/.claude/skills` and `~/.codex/skills`.
- 2026-10-27: rtk enabled for Claude Code (`rtk init -g`).
- 2026-10-27: shfmt added to global mise; polling hook added to Claude Code.
- 2026-10-27: this doc created.
- 2026-10-27: `~/.zshrc` fixed (`compinit` and the Solana `export PATH` were joined on one line).
- 2026-10-27: Brewfile caught up with what is installed (39 entries appended).
- 2026-10-27: deno removed (`~/.deno`, `~/.zsh/completions`, its `~/.zshrc` and fish lines); fnm
  and mongosh dropped from the Brewfile and fish config (neither was installed).
