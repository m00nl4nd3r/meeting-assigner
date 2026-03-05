# CST Meeting Assigner

![Version](https://img.shields.io/badge/version-5.1.0-blue) ![License](https://img.shields.io/badge/license-MIT-green) ![HTML](https://img.shields.io/badge/format-single_file_HTML-orange)

A weekly meeting role assignment tool for Concierge Security Teams. Fairly distributes Presenter, Notes, and Follow-up roles using a ceiling-enforced balancing algorithm.

## Features

- **3 Role Modes** — Solo, 2-Person, 3-Person with per-meeting overrides
- **Containment Test Support** — Forces 3-person mode with CSE3+ Presenter
- **Internal Meetings** — Flag meetings that need no role assignment (listed only)
- **Even-Spread Algorithm** — Fair ceiling enforcement, total-first balancing, role equity
- **Pin & Edit** — Lock members to roles, edit assignments after generation
- **Clean Copy Format** — One readable plain-text format that works everywhere
- **Calendar Export** — .ics with per-member filtering and configurable duration
- **History** — Auto-saves past 20 runs to localStorage
- **Dark/Light Theme** — Warm neutral palette with persistent preference

## Quick Start

```bash
open meeting_assigner.html
```

No server, no build step, no dependencies.

## Copy Output Example

```
CST WEEKLY ASSIGNMENTS
══════════════════════

MONDAY
──────
Acme Corp
  Presenter:  Preston
  Follow-up:  Kaden

Quick Sync  [SOLO]
  Assigned:   Max  (prep, notes & follow-up)

Team Standup  [INTERNAL]
  (no roles assigned)

══════════════════════
STATS  (4 assigned · 1 internal · 3 members)
──────

Preston (CSE3)        Presenter: 2 · Follow-up: 1 · Total: 3  [1-1-1-0-0]
Kaden (CSE2)          Presenter: 1 · Notes: 1 · Total: 2  [1-0-1-0-0]
```

## Algorithm

The v2 engine processes meetings day-by-day (shuffled within each day). For each role slot, it scores candidates on 8 factors (lowest wins):

1. **PTO** — PTO members sort last
2. **Fair ceiling** — Anyone at or above `ceil(totalSlots / members)` deprioritized
3. **Total balance** — Fewest total assignments wins
4. **Role equity** — Never done this role? Strong preference
5. **Daily spread** — Fewer meetings today wins
6. **Role count** — Fewer times in this specific role wins
7. **Pairing diversity** — Less overlap with already-assigned members wins
8. **Alphabetical** — Deterministic tiebreaker

## License

MIT — see [LICENSE](LICENSE)
