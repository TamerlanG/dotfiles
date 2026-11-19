# Git and PRs

- Never commit or push until I approve the change ("commit", "push", "looks good", or a command that says so). Show the diff summary first.
- Never require, ask for, or create an issue before opening a PR. Create the PR directly.
- PR titles and descriptions always follow the humanizer skill: short, simple, clear. At most ~150 words. Say what changed and why; no file-by-file walkthroughs, no headings soup, no marketing.
- After pushing changes that alter what a PR does, update its title and description to match.
- elastic/kibana PRs get the labels `backport:skip`, `release_note:skip`, `team:Operations` unless I say otherwise.
- Replies to PR review comments: at most 30 words, plain tone, cite the fixing commit when there is one.

# Workspace

- Work in the current checkout and branch. Only create a git worktree when I ask for one.
- Lockfiles (`pnpm-lock.yaml`, `yarn.lock`) and generated files such as Kibana's `limits.yml` are regenerated with their tool, never hand-merged.
