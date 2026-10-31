# Cloud environment

The claude.ai cloud environment the nightly routine runs in. These settings exist only in the environment config on claude.ai; this file records what they should be.

| Setting               | Value                                                   |
|-----------------------|---------------------------------------------------------|
| Name                  | `claude-code-dotfiles`                                  |
| Network access        | Custom: only the allowed domains below                  |
| Environment variables | None                                                    |
| Setup script          | `bash /home/user/dotfiles/scripts/cloud/setup.sh`       |

## Allowed domains

```
github.com           # git clone and push
api.github.com       # gh api calls for issues and PRs
archive.ubuntu.com   # apt-get install (zsh, shfmt, shellcheck, tmux)
security.ubuntu.com  # apt-get update
```
