# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [2026-05-23]

### Fixed

- Fix tmux kill-server firing when server has no sessions ([#95](../../pull/95))

## [2026-05-22]

### Added

- Add ghostty terminal emulator configuration ([#93](../../pull/93))

## [2026-05-19]

### Fixed

- Fix Docker image: replace hardcoded username 'jan' with build-arg ([#91](../../pull/91))
- Fix 20_setup_tmux.sh: only run install_plugins when tpm is installed/updated ([#90](../../pull/90))

## [2026-05-18]

### Fixed

- Fix FZF_CTRL_T_COMMAND: add PROJECTS_HOME fallback for non-login shells ([#89](../../pull/89))

## [2026-05-17]

### Fixed

- Guard oh-my-zsh source with directory existence check ([#87](../../pull/87))
- Fix fpath: use HOMEBREW_PREFIX for Apple Silicon compatibility ([#86](../../pull/86))
- Guard starship eval in zshrc with command -v check ([#85](../../pull/85))
- Fix tmux lint: prevent false failure when tpm is not installed ([#84](../../pull/84))

## [2026-05-11]

### Added

- Add vscode workspace settings ([#71](../../pull/71))

### Fixed

- Remove set paste default in vimrc ([#77](../../pull/77))
- Address low-priority codebase review findings ([#76](../../pull/76))

## [2026-05-10]

### Added

- Add tmux-ssh function ([#70](../../pull/70))

### Fixed

- Use glow with custom style and less for paged help rendering ([#69](../../pull/69))

## [2026-04-29]

### Changed

- Move skill/command to agentic-ai, update codebase-reviewer ([#65](../../pull/65))

## [2026-04-27]

### Added

- Add uv aliases for python/pip ([#61](../../pull/61))

## [2026-04-26]

### Changed

- Update tmux help ([#60](../../pull/60))
- Migrate TODO tracking from CLAUDE.md to GitHub Issues ([#57](../../pull/57))

### Fixed

- Pin Python version with uv to fix CI lint ([#58](../../pull/58))

## [2026-04-23]

### Fixed

- Fix 50_setup_vscode.sh — use OS-aware path for VS Code settings ([#45](../../pull/45))

## [2026-04-22]

### Changed

- Housekeeping: TODO list updates ([#43](../../pull/43))
- Mark terraform completion TODO as done in CLAUDE.md ([#40](../../pull/40))

## [2026-04-20]

### Fixed

- Fix AWS CLI tab completion: add `command -v aws_completer` guard ([#38](../../pull/38))
- Fix zshrc fpath: guard stale Intel Homebrew path with existence check ([#36](../../pull/36))
- Fix zshrc terraform completion — guard hardcoded path with existence check ([#34](../../pull/34))

## [2026-04-19]

### Fixed

- Fix zshrc Go block: use go env GOROOT instead of brew --prefix golang ([#32](../../pull/32))

## [2026-04-16]

### Added

- Add shfmt and shellcheck to lint pipeline ([#29](../../pull/29))

### Changed

- shfmt formatting and housekeeping ([#30](../../pull/30))

## [2026-04-15]

### Fixed

- Cross-platform clipboard in tmux copy-mode ([#28](../../pull/28))

## [2026-04-14]

### Fixed

- Fix FZF CTRL-T command ([#27](../../pull/27))

## [2026-04-13]

### Added

- Add codebase-reviewer subagent ([#26](../../pull/26))

### Changed

- Add TODOs from codebase review, mark agent-safe ([#25](../../pull/25))
- Mark agent-safe TODOs for automated processing ([#24](../../pull/24))

## [2026-04-11]

### Added

- Add git analytics aliases ([#23](../../pull/23))

## [2026-04-09]

### Added

- Add Claude GitHub Actions integration ([#17](../../pull/17))

### Fixed

- Move Homebrew PATH setup to zshenv for SSH compatibility ([#22](../../pull/22))
- Use command -v in confirm_binaries instead of broken which pattern ([#19](../../pull/19))

### Changed

- Remove completed TODO items from CLAUDE.md ([#20](../../pull/20))

## [2026-04-08]

### Added

- Add tmux plugin auto-install and update help pages ([#16](../../pull/16))

## [2026-04-03]

### Added

- Add dfh command — dotfiles help system ([#15](../../pull/15))

## [2026-03-31]

### Added

- Add make update target ([#14](../../pull/14))

## [2026-03-30]

### Added

- Add development conventions section to CLAUDE.md ([#13](../../pull/13))
- Add git workflow conventions and /todo command ([#12](../../pull/12))
- Print dotfiles version on interactive shell start ([#9](../../pull/9))

### Fixed

- Fix git tab completion via zstyle ([#11](../../pull/11))
- Handle tmux gracefully during make install ([#10](../../pull/10))

## [2026-03-29]

### Changed

- Update Dockerfile, add nvm to zshrc ([#8](../../pull/8))

## [2026-03-28]

### Changed

- Refactor scripts layout and env var naming ([#7](../../pull/7))

## [2026-03-27]

### Added

- Add lint script, Makefile ([#6](../../pull/6))

## [2026-03-26]

### Changed

- Update CLAUDE.md with architecture docs ([#5](../../pull/5))

## [2026-03-25]

### Added

- Configure AWS pager ([#4](../../pull/4))

### Fixed

- Fix tmux status bar and Docker improvements ([#3](../../pull/3))

## [2026-03-23]

### Changed

- Update README ([#2](../../pull/2))

### Fixed

- Improve zsh completion and fix Linux/Docker setup ([#1](../../pull/1))
