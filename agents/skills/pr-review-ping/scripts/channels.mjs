#!/usr/bin/env node
// Maps a Kibana PR's pending team review requests to Slack channels.
// Usage: node channels.mjs <pr-number>
// Prints JSON: { url, title, internal: [slug], channels: [{ channel, channelId, teams }], unmapped: [{ slug, reason }] }
import { execFileSync } from 'node:child_process';

// Teams whose review requests go to one combined message in the internal channel.
const INTERNAL_TEAMS = new Set(['elastic/kibana-operations', 'elastic/appex-qa']);

const gh = (args) => execFileSync('gh', args, { encoding: 'utf8', maxBuffer: 64 * 1024 * 1024 });
const ghRaw = (repo, path) =>
  gh(['api', `repos/${repo}/contents/${path}`, '-H', 'Accept: application/vnd.github.raw']);
// Both files only use whole-line `//` comments and may have trailing commas.
const parseJsonc = (text) =>
  JSON.parse(text.replace(/^\s*\/\/.*$/gm, '').replace(/,(\s*[\]}])/g, '$1'));

const pr = process.argv[2];
if (!pr) {
  console.error('usage: channels.mjs <pr-number>');
  process.exit(1);
}

const { url, title, reviewRequests } = JSON.parse(
  gh(['pr', 'view', pr, '--repo', 'elastic/kibana', '--json', 'url,title,reviewRequests'])
);
const teams = parseJsonc(
  ghRaw('elastic/kibana', 'src/platform/packages/private/kbn-code-owners/teams.jsonc')
);
const overlays = parseJsonc(ghRaw('elastic/kibana-team', 'teams/overlays.jsonc'));

const idBySlug = new Map(teams.filter((t) => t.github?.team).map((t) => [t.github.team, t.id]));
const slackById = new Map(overlays.map((o) => [o.id, o.slack ?? {}]));

const internal = [];
const unmapped = [];
const byChannel = new Map();

for (const { slug } of reviewRequests.filter((r) => r.slug)) {
  if (INTERNAL_TEAMS.has(slug)) {
    internal.push(slug);
    continue;
  }
  const id = idBySlug.get(slug);
  if (!id) {
    unmapped.push({ slug, reason: 'no github.team match in teams.jsonc' });
    continue;
  }
  const { teamChannel, teamChannelId } = slackById.get(id) ?? {};
  if (!teamChannelId) {
    unmapped.push({ slug, reason: `team id "${id}" has no slack.teamChannelId in overlays.jsonc` });
    continue;
  }
  const entry = byChannel.get(teamChannelId) ?? { channel: teamChannel, channelId: teamChannelId, teams: [] };
  entry.teams.push(slug);
  byChannel.set(teamChannelId, entry);
}

console.log(JSON.stringify({ url, title, internal, channels: [...byChannel.values()], unmapped }, null, 2));
