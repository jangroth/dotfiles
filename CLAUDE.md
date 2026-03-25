## TODO

- [x] Fix `scripts/10_setup_zsh.sh` line 13 failing in Docker (Linux)
- [x] Update `build-container.sh` to use `docker buildx build`
- [x] Update README.md to reflect current tools and setup process.
- [ ] Fix git tab completion — error `_git:.:48: no such file or directory: ""` means `$script` (path to `git-completion.bash`) is not found. The search paths in `files/zsh/completions/_git` (lines 35-43) don't include Homebrew's location on macOS. Fix: add the Homebrew bash-completion path (e.g. output of `brew --prefix`/share/bash-completion/completions/git) to the locations array, or set the zstyle in zshrc.
- [ ] Configure AWS pager — add `export AWS_PAGER=""` to shell env so AWS CLI output is not paged.
- [ ] Implement a helper script that displays configured keyboard shortcuts for different tools (tmux, fzf, vim). Should read from actual config files where possible and present them in a readable format.
- [x] Fix tmux status bar — on startup it shows stale environment (e.g. wifi name and weather) instead of reloading config. Should display user and hostname instead.
