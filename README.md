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
./scripts/99_setup_everything.sh
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

## Testing with Docker

Build and run a Linux container to test the setup:

```sh
./build-container.sh
./run-container.sh
```

Then inside the container:

```sh
~/dotfiles/scripts/99_setup_everything.sh
```

## Helper functions

- `pro [path]` — jump to a project directory under `$PROJECTS_HOME` (`~/Projects` on macOS, `~` on Linux), with tab completion for nested paths
