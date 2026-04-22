# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## conventions

- Keep `README.md` up to date whenever making changes that affect setup, usage, or tooling.

## Git workflow

- Always create a new branch before making any changes — never commit directly to main.
- Always run `make lint` before committing.
- Always check if `README.md` requires updating before committing.
- Never push to remote without explicit user confirmation.

## Development conventions

- When implementing CLI commands or shell functions, ask clarifying questions about the desired interface (argument format, completion behavior) before coding.

## What this repo is

Dotfiles for macOS and Linux. Config files live in `files/`, setup scripts in `scripts/`. Scripts symlink or copy files into `$HOME`.

## Running setup

```sh
make install                                    # run all setup scripts
make reinstall                                  # force re-fetch remote dependencies
./scripts/10_setup_zsh.sh                       # individual script
DOT_FORCE=true ./scripts/10_setup_zsh.sh       # force re-fetch remote dependencies
DOT_VERBOSE=true ./scripts/10_setup_zsh.sh     # verbose/trace output
```

## Testing with Docker (Linux)

```sh
./docker/build.sh    # builds ubuntu:24.04 image with required packages
./docker/run.sh      # mounts repo into container at ~/dotfiles
# inside container:
make install
```

## Architecture

### `scripts/_config.sh`
Shared config sourced by all setup scripts. Sets `$DOT_OS` (`darwin`/`linux`/`windows`) and `$DOT_ROOT` (repo root). Scripts call `confirm_binaries` to fail fast on missing deps.

### `files/` structure
- `zsh/` — `zshenv` (all shells), `zprofile` (login), `zshrc` (interactive). Tool-specific env vars are guarded with `command -v <tool>` checks.
- `shell/aliases` and `shell/functions/` — sourced by `zshrc`; functions are auto-loaded from `~/.zsh/functions/`
- `zsh/completions/` — custom completions copied to `~/.zsh/completions/`
- Other dirs (`git/`, `tmux/`, `vim/`, `starship/`, `vscode/`) each have a corresponding `scripts/NN_setup_*.sh`

### Platform differences
- Linux uses `fdfind` (the Ubuntu package name); macOS uses `fd`
- `$PROJECTS_HOME` resolves to `~/Projects` on macOS, `~` on Linux (set in `zprofile`)
- The Docker image creates a `~/.local/bin/fd → fdfind` symlink to normalize this

## TODO

- [ ] Add `tmux-ssh` function — SSH into a home network machine and attach to tmux (or create a new session if none running). Usage: `tmux-ssh kylo` or `tmux-ssh 192.168.86.201`.
- [x] Fix `tmux.conf` clipboard — `pbcopy` is macOS-only; Linux needs `xclip` or `wl-copy`. <!-- agent-safe -->
- [ ] Add oh-my-zsh `Makefile` plugin for cleaner make tab completion (targets only). <!-- agent-safe -->
- [ ] Enable/fix AWS CLI tab completion — add `command -v aws_completer` guard in `zshrc`; currently registers broken completion if `aws_completer` is not on PATH. <!-- agent-safe -->
- [ ] Fix `zshrc` terraform completion — hardcoded `/opt/homebrew/bin/terraform` with no existence check; errors on every shell start if not installed. <!-- agent-safe -->
- [ ] Enable/fix kubectl tab completion — not currently configured in `zshrc`.
- [x] Fix `zshrc` Go block — replace `brew --prefix golang` with `go env GOROOT`; current form fails on Linux. <!-- agent-safe -->
- [ ] Fix `50_setup_vscode.sh` — hardcodes `~/Library/Application Support/Code/User` with no OS guard; will fail on Linux. <!-- agent-safe -->
- [ ] Fix `zshenv` Homebrew init — only checks Apple Silicon path (`/opt/homebrew`); Intel Macs (`/usr/local`) silently get no Homebrew on PATH. <!-- agent-safe -->
- [x] Fix `zshrc` FZF_CTRL_T_COMMAND — uses `fd` unconditionally; broken on Linux without the Docker `fd→fdfind` symlink. <!-- agent-safe -->
- [ ] Fix `zshrc` fpath — includes stale Intel Homebrew path (`/usr/local/share/zsh/site-functions`); should be guarded or replaced. <!-- agent-safe -->
- [ ] Fix `scripts/20_setup_tmux.sh` — `tmux kill-server` fires when `list-sessions` fails, which also happens when a server is running but has no sessions.
- [ ] Fix `gitconfig` hardcoded user identity — `name`/`email` silently overwrite git config on any machine running `make install`.
- [ ] Make the Docker image reusable as a generic development container (e.g. configurable base image, dev tools, volume mounts).
- [ ] Add support and documentation for tmux window movement.
