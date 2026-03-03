# CST Meeting Assigner

![Version](https://img.shields.io/badge/version-5.0.0-blue) ![License](https://img.shields.io/badge/license-MIT-green) ![HTML](https://img.shields.io/badge/format-single_file_HTML-orange)

A weekly meeting role assignment tool for Concierge Security Teams. Fairly distributes Presenter, Notes, and Follow-up roles using a multi-factor balancing algorithm.

## Features

- **3 Role Modes** — Solo, 2-Person, 3-Person with per-meeting overrides
- **Containment Test Support** — Forces 3-person mode with CSE3+ Presenter requirement
- **Multi-Factor Algorithm** — Balances PTO, daily spread, pairing diversity, role balance, and total balance
- **Pin & Edit** — Pin specific members to roles, edit assignments after generation
- **3 Copy Formats** — Slack, OneNote, and Markdown with scannable one-line-per-meeting design
- **Calendar Export** — .ics file generation with per-member filtering and configurable duration
- **History** — Auto-saves past runs to localStorage (max 20)
- **Dark/Light Theme** — Persisted preference with warm neutral color palette

## Quick Start

Just open the file — no server, no build step, no dependencies:

```bash
open meeting_assigner.html
# or
python3 -m http.server 8080
# or with Docker:
docker compose up
```

## Walkthrough

### Step 1: Team Setup
1. Choose your role mode (Solo / 2-Person / 3-Person)
2. Add team members with their CSE level (1–5)
3. Enter meetings per weekday (one per line)
4. Click **Continue**

### Step 2: Meeting Configuration
- Toggle **🔒 Containment Test** for CT meetings (forces 3 roles, CSE3+ Presenter)
- Toggle **👤 Solo** for meetings one person handles alone
- Uncheck members under **Available** to hard-exclude them
- Check **🏖️ PTO** to soft-deprioritize (they can still be assigned as fallback)
- Use **📌 Pin** dropdowns to lock a specific member into a role

### Step 3: Results
- View assignments grouped by day with role details
- Click **✏️** on any card to edit assignments inline
- Switch format (Slack / OneNote / Markdown) and copy or export

## Copy Format Examples

**Slack** — One line per meeting with emoji role icons:
```
*Monday*
  *Acme Corp*  →  🎤 *Preston*  ·  ✅ *Kaden*
  *Quick Sync*  →  *Max* 👤
```

**OneNote** — Tabular with aligned columns for pasting into docs:
```
MONDAY
──────────────────────────────
  Acme Corp
    Presenter:     Preston
    Follow-up:     Kaden
```

**Markdown** — Proper tables and headers for README/wiki:
```markdown
### Monday
**Acme Corp** → 🎤 Preston · ✅ Kaden
```

## Algorithm

The assignment engine processes meetings day-by-day (shuffled within each day). For each role, it scores all available candidates on 6 factors (ascending — lowest wins):

1. **PTO** — PTO members sort last (but aren't excluded)
2. **Daily Spread** — Fewer meetings this day = better
3. **Pairing Diversity** — Fewer times paired with already-assigned members = better
4. **Role Balance** — Fewer times in this specific role = better
5. **Total Balance** — Fewer total assignments = better
6. **Alphabetical** — Deterministic tiebreaker

Tallies update in real-time, so later meetings benefit from up-to-date counts.

## Per-Meeting Solo Override

Even in 2-Person or 3-Person mode, individual meetings can be flagged **Solo** in Step 2. This assigns one person who handles prep, notes, and follow-up. Containment Tests override Solo (CT always uses 3 people).

## Troubleshooting

| Issue | Fix |
|-------|-----|
| "Not enough available members" | Increase available members or reduce role mode |
| CT Presenter constraint fails | Ensure at least one CSE3+ member is available |
| Assignments seem unbalanced | Add more meetings or members for better distribution |
| History not saving | Check browser localStorage is enabled |
| Copy not working | Browser may require HTTPS for clipboard API |

## License

MIT — see [LICENSE](LICENSE)
