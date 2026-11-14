---
name: pr-review-ping
description: Posts review requests for a Kibana PR to each pending code-owner team's Slack channel. Use when asked to ping teams, ask for reviews, or nudge reviewers on Slack for a PR.
---

# PR review ping

Sends a review request for a Kibana PR to the Slack channel of every team whose review is still pending. Uses the Slack MCP tools.

## 1. Map teams to channels

```bash
node ~/.agents/skills/pr-review-ping/scripts/channels.mjs <pr-number>
```

Without a number, get it from `gh pr view --json number` for the current branch.

The script reads the PR's pending team review requests, then joins:

- GitHub team slug → team `id` via `src/platform/packages/private/kbn-code-owners/teams.jsonc` (elastic/kibana, public).
- Team `id` → `slack.teamChannel` / `teamChannelId` via `teams/overlays.jsonc` (elastic/kibana-team, private).

Slugs and ids differ (`elastic/kibana-operations` → `operations`, `elastic/appex-qa` → `qa`), so never match the overlay on the slug directly.

Output fields:

| Field | Meaning |
|---|---|
| `channels` | One entry per unique channel with the teams it covers (several teams can share a channel) |
| `internal` | `elastic/kibana-operations` and `elastic/appex-qa` if pending. These don't go to their team channels |
| `unmapped` | Teams with no registry entry or no Slack channel |

## 2. Show the plan and confirm

Before sending anything, show the user:

- A table of team → channel → channel ID.
- The `internal` message, if any (see step 3).
- The `unmapped` teams.

Ask which channels to send to. Send nothing until the user confirms.

## 3. Send

Team channels, one message each, with `slack_send_message` and the channel ID:

```
hey folks, would appreciate a review for: <pr-url>
```

If `internal` isn't empty, send **one** message to the private channel `#apps-dx-crew` instead of the ops/QA team channels. Look up its ID with `slack_list_user_channels` (`name_prefix: "apps-dx-crew"`):

```
[ops/qa] review needed for <pr-url>
```

## 4. Report

List every sent message with its link, and every failure with the reason.

`not_in_channel` means the user isn't a member. The Slack MCP can't join channels, and joining is a visible action. Report these channels and resend only after the user says they've joined.
