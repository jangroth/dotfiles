# Nightly todo routine

Run daily by the "dotfiles - nightly todo" Claude Code routine.

1. Fetch open GitHub issues labelled agent-safe: `gh issue list --label agent-safe --state open --json number,title,body`
2. Fetch open PRs: `gh pr list --state open --json number,headRefName,body`
3. Exclude issues already in flight. An issue is in flight if an open PR's branch matches `auto/issue-<number>-*` or its body references the issue (e.g., "Closes #<number>" or "#<number>").
4. Pick one remaining issue at random. If none are eligible, exit cleanly with a summary of what was checked.
5. Create a new branch named `auto/issue-<number>-<slug>`.
6. Implement the fix according to the rules in CLAUDE.md.
7. Run `make lint` to verify your changes pass all local styling and tool checks.
8. Open a GitHub PR referencing the issue (include "Closes #<number>" in the body). Assign it to jangroth and mark it for human review. Do not auto-merge.
9. Do not modify this file or `scripts/cloud/setup.sh` unless the issue explicitly asks for it.
