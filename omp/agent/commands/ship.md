---
description: Commit, push, and open or update the PR
argument-hint: "[draft] [notes]"
---

Ship the current work. This command is my approval to commit and push. Arguments: $ARGUMENTS

1. If on `main` or a release branch, create a new branch with a short descriptive name first.
2. Commit the changes in logical commits with clear messages.
3. In elastic/kibana, run `env -u CI node scripts/quick_checks` on the committed tree (it flags any uncommitted file as a change). Commit its fixes as a separate commit.
4. Push.
5. If the branch has no PR, create one (as a draft if `draft` was passed), with no issue. If it has one, update its title and description to match the current state.
6. Write the title and description with skill://humanizer: short, simple, clear. Add the default labels from my rules.

Print the PR URL at the end.
