---
description: Root-cause a Buildkite failure; `watch` keeps fixing until green
argument-hint: "<buildkite-url|PR> [watch]"
---

Investigate CI: $ARGUMENTS
If no build is given, use the latest Buildkite build for the current branch's PR.

1. Use the Buildkite CLI as `env -u CI bk …` (not `gh` checks) to list failed jobs and read their logs.
2. Group failures by root cause. For each: failing job(s), the error excerpt, the cause, and whether it comes from this change, main, or flakiness/infra.
3. Propose the fix. Do not change code yet unless `watch` was passed.

With `watch`: fix the failures that come from this change, commit, push, wait for the new build, and repeat until it is green or only failures unrelated to this change remain. Report each round in one line.
