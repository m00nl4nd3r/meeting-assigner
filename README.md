# CST Meeting Assigner

![Version](https://img.shields.io/badge/version-5.2.0-blue) ![License](https://img.shields.io/badge/license-MIT-green) ![HTML](https://img.shields.io/badge/format-single_file_HTML-orange)

A weekly meeting role assignment tool for Concierge Security Teams. Fairly distributes Presenter, Notes, and Follow-up roles using a ceiling-enforced balancing algorithm.

## Features

- **3 Role Modes** — Solo, 2-Person, 3-Person with per-meeting overrides
- **Containment Test Support** — Forces 3-person mode with CSE3+ Presenter
- **Internal Meetings** — Flag meetings that need no role assignment (listed only)
- **Even-Spread Algorithm** — Fair ceiling enforcement, total-first balancing, role equity
- **Pin & Edit** — Lock members to roles, edit assignments after generation
- **Retroactive Editing** — Load any past result from history, edit it, changes save back
- **Last Edited Tracking** — Every edit timestamped; shown in results, copy output, and history
- **JSON Backup & Import** — Export single results or full history. Import via file, drag-drop, or paste
- **Clean Copy Format** — One readable plain-text format that works everywhere
- **Calendar Export** — .ics with per-member filtering and configurable duration
- **History** — Auto-saves past runs to localStorage (20 new, 50 with imports)
- **Dark/Light Theme** — Warm neutral palette with persistent preference

## Quick Start

```bash
open meeting_assigner.html
```

No server, no build step, no dependencies.

## Copy Output Example

```
┌─────────────────────────────────────────┐
│     📋  CST WEEKLY ASSIGNMENTS          │
│     Week of 2026-03-05                  │
└─────────────────────────────────────────┘


━━━  MONDAY  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    Acme Corp

        🎤  Presenter   →   Preston
        ✅  Follow-up   →   Kaden

    ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄

    Quick Sync   ‹ 👤 SOLO ›

        ➜  Max
           handles prep, notes & follow-up

    ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄

    Team Standup   ‹ 🏢 INTERNAL ›
        (no roles assigned)


┌─────────────────────────────────────────┐
│     📊  STATS                           │
│     3 assigned  ·  1 internal  ·  3 members│
└─────────────────────────────────────────┘

    MEMBER                PRES    NOTES   F/U     TOTAL   M-T-W-T-F
    ─────────────────────────────────────────────────────────────────
    Preston  (CSE3)       2       ·       1       3       1-1-1-0-0
    Kaden  (CSE2)         ·       ·       2       2       1-0-1-0-0
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

## Backup & Import

**Export single result:** Click "Export .json" in the results bar to save the current assignment.

**Backup all history:** Open the history sidebar (☰) and click "Backup All History (.json)" to export every saved run as one file.

**Import:** In the history sidebar, click "Import from JSON" to reveal the import area. You can drag-drop a `.json` file, click to browse, or paste raw JSON. The importer auto-detects whether you're importing a full backup or a single assignment and deduplicates by ID.

## Retroactive Editing

When you load a past result from history, any edits you make (via the ✏️ button on assignment cards) save back to that same history entry — no duplicates are created. Every edit stamps a `lastEdited` timestamp that appears in the results bar, in copied/exported text, and as a green dot on the history entry.
