# Changelog

## [5.1.0] — 2026-03-05

### Added
- **Internal meetings** — new 🏢 Internal flag in Step 2. Internal meetings have no roles assigned and appear in output as "(no roles assigned)". Checking Internal auto-clears CT and Solo flags.
- **Fair ceiling algorithm** — assignments now enforce `ceil(totalSlots / memberCount)` as a hard cap, preventing any member from being overloaded while others sit idle.
- **Role equity pass** — members who have never held a particular role get strong preference, spreading role variety across the team.

### Changed
- **Copy/paste completely rewritten** — removed Slack/OneNote/Markdown format toggle. Now one clean plain-text format that reads well everywhere (Slack, Teams, email, OneNote, docs). Solo meetings clearly tagged `[SOLO]` with "(prep, notes & follow-up)" label. Internal meetings tagged `[INTERNAL]`.
- **Algorithm sort order overhauled** — total balance now beats daily spread (fewest total assignments wins first). Fair ceiling check inserted as factor #2 after PTO. Pairing diversity demoted to tiebreaker.
- **Simplified results bar** — removed format toggle buttons. Copy All / Copy Assignments / Copy Stats + Export .txt / .ics.
- **Text export simplified** — no longer saves/restores format state since there's only one format.

### Fixed
- All v5.0.0 edge case fixes preserved (string IDs, isCSE3R parameter, ICS variable naming, Step 2 state preservation).

## [5.0.0] — 2026-03-03

### Added
- Complete ground-up rebuild from 7-session specification
- Multi-factor assignment algorithm
- Per-meeting Solo override, Containment Test flag
- 3 copy formats (Slack, OneNote, Markdown)
- Inline edit panel, ICS export, history sidebar, dark/light theme
