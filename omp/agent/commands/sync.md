---
description: Update branch(es) from main, resolve conflicts, push
argument-hint: "[PR URLs or numbers…]"
---

Bring these PRs up to date with their base branch: $ARGUMENTS
If no PRs are given, use the current branch and its PR.

For each PR, one at a time:
1. Check out its branch (`gh pr checkout <n>` when it is not the current branch). Fetch, then merge the PR's base branch (usually `origin/main`). Merge, never rebase, unless I say otherwise.
2. Resolve conflicts by keeping both sides' intent. Regenerate lockfiles and generated files (`pnpm install`, Kibana `limits.yml`, moon projects, etc.) instead of hand-merging them. Commit the merge.
3. In elastic/kibana, run `env -u CI node scripts/quick_checks` on the committed tree (it flags any uncommitted file as a change). Commit its fixes as a separate commit.
4. Push. This command is my approval to push.
5. If the merge changed what the PR does, update the PR description.

Finish with one line per PR: conflicts resolved (files), checks result, pushed SHA. Stop and ask if a conflict needs a product decision.
