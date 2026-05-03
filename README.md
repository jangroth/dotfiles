# Dotfiles

My dotfiles for macOS and Linux.

## Tools configured

- **zsh** — shell config, aliases, functions, completions, oh-my-zsh plugins (fzf, autosuggestions, syntax highlighting)
- **starship** — shell prompt
- **tmux** — terminal multiplexer
- **vim** — editor
- **git** — global config
- **vscode** — editor settings

## Setup

Run all setup scripts at once:

```sh
make update                # pull latest and install
make install               # skip already-installed dependencies
make reinstall             # force re-fetch all remote dependencies
DOT_VERBOSE=true make install  # verbose/trace output
```

Or run individual scripts:

```sh
./scripts/10_setup_zsh.sh
./scripts/15_setup_starship.sh
./scripts/20_setup_tmux.sh
./scripts/30_setup_vim.sh
./scripts/40_setup_git.sh
./scripts/50_setup_vscode.sh
```

## Linting

Check syntax of all config and shell files:

```sh
make lint
```

## Testing with Docker

Build and run a Linux container to test the setup:

```sh
make docker-build
make docker-run
```

Then inside the container:

```sh
make install
```

## Helper functions

- `pro [path]` — jump to a project directory under `$PROJECTS_HOME` (`~/Projects` on macOS, `~` on Linux), with tab completion for nested paths
- `dfh [topic]` — dotfiles help; run `dfh` for version info and available topics, `dfh tmux` / `dfh fzf` / `dfh vim` for keybinding references extracted from config files
- `tmux-ssh <host>` — SSH into a machine and attach to (or create) a tmux session named `main`; e.g. `tmux-ssh kylo` or `tmux-ssh 192.168.86.201`
