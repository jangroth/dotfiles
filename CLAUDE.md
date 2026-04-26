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

Tracked as GitHub issues with the `todo` label: `gh issue list --label todo`
