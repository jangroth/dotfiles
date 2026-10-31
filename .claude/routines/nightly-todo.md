# Nightly todo routine

Run daily by the "dotfiles - nightly todo" Claude Code routine. The routine prompt only points to this file.

## Routine settings

| Setting       | Value                                                                 |
|---------------|-----------------------------------------------------------------------|
| Trigger       | `trig_01Moqsv7toUy9TadrYnJvwLc`                                       |
| Schedule      | `0 11 * * *`: 11:00 UTC daily (21:00 AEST, same day)                   |
| Model         | claude-opus-5-5                                                       |
| Allowed tools | Bash, Read, Write, Edit, Glob, Grep, WebFetch, WebSearch              |
| Environment   | `claude-code-dotfiles`, see [cloud-environment.md](cloud-environment.md) |
| Source        | `jangroth/dotfiles`                                                   |

## Prompt

GraphQL is blocked in cloud sessions, so `gh issue list` / `gh pr list` fail; use `gh api` (REST).

1. Fetch open issues labelled `agent-safe`: `gh api "repos/jangroth/dotfiles/issues?state=open&labels=agent-safe&per_page=100" --jq '[.[] | select(.pull_request == null) | {number, title, body}]'`
2. Fetch open PRs: `gh api "repos/jangroth/dotfiles/pulls?state=open&per_page=100" --jq '[.[] | {number, branch: .head.ref, body}]'`
3. Exclude issues already in flight. An issue is in flight if an open PR's branch matches `auto/issue-<number>-*` or its body references it (e.g. `Closes #<number>` or `#<number>`).
4. Pick one remaining issue at random. If none are eligible, exit cleanly with a summary of what was checked.
5. Create a new branch named `auto/issue-<number>-<slug>` from `origin/main`.
6. Implement the fix according to the rules in CLAUDE.md.
7. Run `make lint` to verify the change passes all local style and tool checks.
8. Open a PR with `Closes #<number>` in the body. Assign it to jangroth and mark it for human review. Do not auto-merge.
9. Do not modify this file, `cloud-environment.md` or `scripts/cloud/setup.sh` unless the issue explicitly asks for it.
