---
description: Validate PR review comments, fix the worthwhile ones, reply
argument-hint: "[comment URLs…]"
---

Triage review comments: $ARGUMENTS
If no URLs are given, take every unresolved review thread on the current branch's PR (human and AI reviewers alike).

For each comment:
1. Read the comment, its replies, and the code it points at.
2. Verdict: **valid**, **invalid**, or **nitpick**, with one line of evidence.
3. Fix it only when it is valid and the fix is small and contained. Defer large or risky changes, and say why.

Then show me a table: comment, verdict, action (fixed / deferred / no change). Do not commit, push, or reply yet.

After I approve: commit, push, reply to each thread (at most 30 words; cite the fixing commit), and resolve the threads that were fixed or answered.
