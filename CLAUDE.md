# dotfiles

Shell, editor, git, tmux and terminal config for macOS and Linux. Config files live in `files/`, setup scripts in `scripts/`. Scripts symlink or copy files into `$HOME`.

## Conventions

- Run `make lint` before committing.
- Keep `README.md` up to date with any change to setup, usage or tooling; check it before committing.
- When implementing CLI commands or shell functions, ask clarifying questions about the desired interface (argument format, completion behavior) before coding.

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
./docker/build.sh    # builds debian:12.13-slim image with required packages
./docker/run.sh      # mounts repo into container at ~/dotfiles
# inside container:
make install
```

## Writing config and scripts

- Each `files/<tool>/` dir has a matching `scripts/NN_setup_<tool>.sh`. A setup script sources `scripts/_config.sh` (`$DOT_OS`, `$DOT_ROOT`) and calls `confirm_binaries` for its deps.
- Guard tool-specific env vars in `files/zsh/` with `command -v <tool>`.
- Shell functions go in `files/shell/functions/`, one per file; they're auto-loaded from `~/.zsh/functions/`.

## Platform differences

- Linux uses `fdfind` (the Ubuntu package name); macOS uses `fd`. The Docker image symlinks `~/.local/bin/fd → fdfind`.
- `$PROJECTS_HOME` resolves to `~/Projects` on macOS, `~` on Linux (set in `zprofile`).

## Issues

Tracked as GitHub issues with the triage labels from the user-level `CLAUDE.md`. `ready-for-agent` issues are picked up by the nightly routine.
