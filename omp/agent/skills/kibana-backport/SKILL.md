---
name: kibana-backport
description: >
  Backport a merged Kibana PR to release branches with `node scripts/backport`,
  resolving cherry-pick conflicts in ~/.backport/repositories/elastic/kibana
  and confirming through the interactive CLI (never `git cherry-pick
  --continue`). Use when the user asks to backport a PR number to one or more
  branches (e.g. 9.4, 8.19), or says "backport", "run the backport script",
  or "fix backport conflicts".
argument-hint: "<pr-number> <branch> [<branch> ...]"
---

# Kibana backport

Run one branch at a time. If the user lists several branches and asks for a
"test run", do only the first branch, report the result, and wait for approval
before doing the others.

## 1. Start the CLI (one branch per run)

Run it from the Kibana repo root as a named pty service so you can answer the
prompts:

```
bash(name: "backport-<branch>", pty: true,
     command: "node scripts/backport --pr <PR> --branch <branch>",
     ready: { log: "Select pull request", timeout: 300 })
```

- The CLI asks you to confirm the PR (`? Select pull request ...`). Send a
  single Enter: write empty content to `proc://backport-<branch>`.
- Fetching and cherry-picking take about 1–2 minutes. Don't poll in a tight
  loop. Sleep about 90s, then read `proc://backport-<branch>`.
- If the cherry-pick applies cleanly, the CLI pushes the branch and opens the
  PR without more input. Go to step 4.

## 2. Resolve conflicts (worktree: `~/.backport/repositories/elastic/kibana`)

When conflicts happen, the CLI prints `Conflicting files:` and the prompt
`Press ENTER when the conflicts are resolved and files are staged (Y/n)`.

- The first copy of that prompt often shows `Yes` right away, because of
  buffered input. The CLI sees the files are still conflicted and asks again.
  That's expected; ignore it.
- In that worktree, run
  `git status --short | grep -v '^M ' ; git diff --diff-filter=U` to see the
  conflict hunks.
- Read the original commit to learn what it meant to change:
  `git show <sha> --stat` and `git show <sha> -- <file>`. The sha appears in
  the conflict markers (`>>>>>>> <sha> (<title> (#<PR>))`).
- Apply the commit's change (theirs relative to base) on top of what the
  release branch has (ours). Keep any lines that exist only on the release
  branch. Don't take a whole side blindly.
- `package.json` / `pnpm-lock.yaml`: resolve by hand. Only the lines the
  original commit touched should change. Before removing package entries
  from the lockfile, check whether other packages still depend on them on
  that branch: grep for `<pkg>@<version>` in the lockfile.
- Never run `git cherry-pick --continue`, `--abort`, or `git commit` yourself.
  The CLI owns the cherry-pick.

## 3. Verify, stage, confirm

```
git add <resolved files>
git status --short            # no UU entries left
git diff --cached --stat      # compare with `git show <sha> --stat`
```

The staged stat should match the original commit's file list and line counts,
unless the branch really needs something different. If it doesn't match,
explain why in the report. Also check that no conflict markers are left
(`^<<<<<<<|^>>>>>>>`).

Then send `Y` + newline to `proc://backport-<branch>`, and wait for the service
to exit.

## 4. Report

Read the end of `proc://backport-<branch>` and report:
- PR URL (`View pull request: ...`), branch `<user>:backport/<branch>/pr-<PR>`,
  labels, and auto-merge status
- each conflict: its cause (what differs on the release branch) and how you
  resolved it
- confirmation that the staged diff matched the original commit

Then move on to the next branch, or ask before continuing if this was a test run.
