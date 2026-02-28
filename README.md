# CST Meeting Assigner

A lightweight, single-file web application that automatically assigns team members to meetings with balanced workload distribution. Built for Customer Success teams managing weekly meeting rotations across multiple days and clients.

**Zero dependencies. No build step. No backend. Just open the HTML file.**

![Version](https://img.shields.io/badge/version-4.5.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Docker](https://img.shields.io/badge/docker-ready-blue)

---

## Why This Exists

Assigning team members across 20+ weekly client meetings by hand is tedious and error-prone. You end up with one person overloaded on Mondays, the same two people always paired together, and nobody remembers whose turn it is to present a Containment Test.

This tool solves that in one click: paste your meetings, set your constraints, and get balanced assignments with copy-paste-ready output for Slack, OneNote, or Markdown.

---

## Features

### Core Assignment Engine
- **Smart multi-factor balancing** — Assignments are sorted by 6 weighted factors to ensure fair distribution:
  1. PTO status (non-PTO members preferred)
  2. Daily count (spread members across the day)
  3. Pairing rotation (minimize repeated partner combinations)
  4. Role count (balance who presents vs. who takes notes)
  5. Total count (overall workload balance)
  6. Alphabetical (deterministic tiebreaker)
- **Shuffle within days** — Meetings within each day are randomized before assignment to prevent positional bias, but results are displayed in original input order
- **Containment Test enforcement** — CT meetings always get 3 roles (Presenter + Notes + Follow-up) regardless of mode, with CSE3+ required as Presenter

### Flexible Role Modes

| Mode | Roles Assigned | Use Case |
|------|---------------|----------|
| **Solo** | Presenter only | Quick check-ins, status updates, 1-person teams |
| **2 People** | Presenter + Follow-up | Standard client meetings |
| **3 People** | Presenter + Notes + Follow-up | Complex or high-stakes meetings |

Individual meetings can be overridden in Step 2:
- **Containment Test (CT)** toggle forces 3 roles with CSE3+ Presenter constraint
- **Solo** toggle forces single-person assignment regardless of global mode

### Dynamic Team Size
- Add or remove team members freely (minimum 1)
- Each member has a configurable CSE level (CSE2, CSE3, CSE4)
- CSE level determines eligibility for CT Presenter role (CSE3+ required)
- No hardcoded team size — works for teams of 1 to any number

### Per-Meeting Controls (Step 2)

For each meeting you can set:

| Control | Effect |
|---------|--------|
| **🔒 Containment Test** | Forces 3-person mode with CSE3+ Presenter |
| **👤 Solo** | Forces single Presenter regardless of global mode |
| **Availability** | Uncheck members who can't attend (hard exclude) |
| **🏖️ PTO** | Mark members on PTO (soft deprioritize, not excluded) |
| **📌 Pin** | Force specific members into specific roles |

### Multi-Format Copy System

One-click copy in three formats, each optimized for its target platform:

<details>
<summary><strong>💬 Slack Format</strong></summary>

Bold text, emoji markers, quote-block-friendly indentation:

```
📅 *CST Weekly Assignments*

*━━━ MONDAY ━━━*

📌 *Acme Corp*
      🎤 Presenter: *Preston* (CSE3)
      ✅ Follow-up: *Kaden* (CSE2)

📌 *Globex Inc*  🔒 _CT_
      🎤 Presenter: *Preston* (CSE3)
      📝 Notes: *Max* (CSE2)
      ✅ Follow-up: *Kaden* (CSE2)

📌 *Quick Sync*  👤 _Solo_
      🎤 Presenter: *Kaden* (CSE2)
```

</details>

<details>
<summary><strong>📓 OneNote Format</strong></summary>

Clean plain text with heading-style days, aligned columns, and generous spacing:

```
CST WEEKLY ASSIGNMENTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━


▸ MONDAY
  ────────────────────────

    Acme Corp

        Presenter:    Preston  (CSE3)
        Follow-up:    Kaden  (CSE2)


    Globex Inc  [CT]

        Presenter:    Preston  (CSE3)
        Notes:        Max  (CSE2)
        Follow-up:    Kaden  (CSE2)



▸ TUESDAY
  ────────────────────────

    Quick Sync  [Solo]

        Presenter:    Kaden  (CSE2)
```

</details>

<details>
<summary><strong>📝 Markdown Format</strong></summary>

Standard markdown with headers and lists:

```markdown
## CST Weekly Assignments

### Monday
**Acme Corp**
- Presenter: Preston (CSE3)
- Follow-up: Kaden (CSE2)

**Globex Inc** [CT]
- Presenter: Preston (CSE3)
- Notes: Max (CSE2)
- Follow-up: Kaden (CSE2)

**Quick Sync** [Solo]
- Presenter: Kaden (CSE2)
```

</details>

Copy buttons: **Copy Assignments** · **Copy Stats** · **Copy All** (assignments first, stats last)

### Tally & Analytics
- Per-member role counts (Presenter, Notes, Follow-up, Total)
- Daily distribution breakdown (M-T-W-T-F)
- Pairing counts showing how often each pair works together
- Visual pairing matrix table

### Edit & Recalculate
- Inline edit any assignment after generation
- Validation prevents duplicate members per meeting and enforces CT CSE3+ constraint
- Full tally recalculation on every save
- Edit indicators (✏️) persist on modified roles

### Export Options

| Export | Description |
|--------|-------------|
| **📋 Copy Assignments** | Copies just the assignments in selected format |
| **📋 Copy Stats** | Copies just the stats/tally section in selected format |
| **📋 Copy All** | Assignments first, then stats, with format-appropriate separator |
| **💾 Export .txt** | Downloads a plain-text file (OneNote format, assignments first) |
| **📆 Export .ics** | Downloads calendar events with member filter and duration control |

### Calendar Export (.ics)
- Filter by individual member to get only their meetings
- Configurable duration: 15 / 30 / 45 / 60 minutes
- Proper iCalendar format with CRLF line endings
- Events include full role assignments in description
- CT (🔒) and Solo (👤) indicators in event titles

### History
- Last 20 assignment sets saved to localStorage
- Collapsible summaries with member counts and stats
- Load & view past results instantly
- Auto-updates when you edit assignments
- Clear all with confirmation modal

### Theme
- Dark mode (default) and light mode
- Persists across sessions via localStorage
- DM Sans + JetBrains Mono typography
- Warm neutral palette with terracotta accent

---

## Quick Start

### Option 1: Just Open It

Download [`meeting_assigner.html`](meeting_assigner.html) and open it in any modern browser. That's it. No server needed.

```bash
git clone https://github.com/m00nl4nd3r/meeting-assigner.git
cd meeting-assigner
open meeting_assigner.html       # macOS
xdg-open meeting_assigner.html   # Linux
start meeting_assigner.html      # Windows
```

### Option 2: Docker

```bash
docker build -t meeting-assigner .
docker run -d -p 8080:80 --name meeting-assigner meeting-assigner
```

Open [http://localhost:8080](http://localhost:8080).

### Option 3: Docker Compose

```bash
docker compose up -d
```

Open [http://localhost:8080](http://localhost:8080).

To stop:

```bash
docker compose down
```

### Option 4: Deploy Script

```bash
chmod +x deploy.sh
./deploy.sh
```

The script auto-detects Docker Compose vs standalone Docker and handles the build for you.

---

## Usage Walkthrough

### 1. Set Role Mode

Choose your default: **Solo** (1 person), **2 People**, or **3 People**. This sets the baseline for all meetings. Individual meetings can override this in Step 2.

### 2. Enter Team & Meetings

**Team Members**: Click "+ Add member" to grow your team. Set each member's name and CSE level. Remove members with the × button. Minimum 1 member (for solo mode).

**Meetings**: Type meeting/customer names into the day columns (Mon–Fri), one per line. Blank lines are ignored.

### 3. Review & Adjust

Each meeting gets a card with toggles:

- **🔒 CT** — Containment Test: forces 3 roles, requires CSE3+ Presenter
- **👤 Solo** — Overrides to single Presenter (hidden if CT is on, since CT takes priority)
- **Available** — Uncheck to hard-exclude a member from this meeting
- **🏖️ PTO** — Soft flag: PTO members are deprioritized but not excluded
- **📌 Pin** — Expand to lock specific members into specific roles

### 4. Generate & Copy

Click **Confirm & Assign** to run the algorithm. Then:

1. Select your output format (Slack / OneNote / Markdown)
2. Copy tally, assignments, or both
3. Edit any assignment inline if needed
4. Export to `.txt` or `.ics` calendar file

---

## Algorithm

The engine processes meetings day by day. Within each day, meetings are shuffled randomly to prevent positional bias. For each meeting, roles are filled in order (Presenter → Notes → Follow-up) by sorting candidates through a 6-factor priority:

```
Priority 1: PTO status       → Non-PTO members preferred
Priority 2: Daily count      → Fewest meetings today goes first
Priority 3: Pairing count    → Minimize repeated pairings with already-assigned
Priority 4: Role count       → Balance who gets which specific role
Priority 5: Total count      → Overall workload balance
Priority 6: Alphabetical     → Deterministic tiebreaker
```

**Containment Test logic**: Only CSE3+ members can present CTs. The algorithm prefers non-PTO CSE3+ candidates, but will fall back to PTO CSE3+ if no alternative exists. If no CSE3+ is available at all, an error is shown.

**Solo meetings**: When a meeting is marked solo (or the global mode is Solo), only the Presenter role is assigned. The algorithm still respects availability, PTO, and pin constraints.

**String ID safety**: All meeting IDs from HTML `data-*` attributes are cast to strings via `String(meeting.id)` before any map lookup. This prevents the silent type-mismatch bug where `pinned[0]` (number) misses `pinned["0"]` (string key).

---

## Project Structure

```
meeting-assigner/
├── meeting_assigner.html   # The entire application (single file, ~70KB)
├── Dockerfile              # Nginx Alpine container
├── docker-compose.yml      # Compose config with healthcheck
├── deploy.sh               # Auto-detect deployment script
├── CHANGELOG.md            # Version history
├── LICENSE                 # MIT License
└── README.md               # You are here
```

The entire app is a single HTML file with embedded CSS and vanilla JavaScript. No frameworks, no bundlers, no `node_modules`. It runs entirely in the browser using localStorage for persistence.

---

## Technical Details

| Property | Value |
|----------|-------|
| Architecture | Single HTML file, vanilla JS, zero dependencies |
| Storage | localStorage only (browser-local, no server) |
| Min Team Size | 1 member (solo mode) |
| Max Team Size | Unlimited |
| Max History | 20 entries (oldest auto-pruned) |
| Offline Support | Full — no network requests after initial load |
| Browser Support | Chrome, Firefox, Safari, Edge (any modern browser) |
| Container Image | Nginx Alpine (~7MB) |
| Container Port | 80 (mapped to 8080 on host by default) |
| Fonts | DM Sans (body), JetBrains Mono (labels/data) via Google Fonts |

---

## Troubleshooting

**Assignments seem unbalanced**
The algorithm shuffles meetings within each day before assigning. Run it multiple times — you'll see different but always balanced distributions. The tally section provides exact counts for verification.

**CT Presenter is wrong CSE level**
Only CSE3+ members can present Containment Tests. Check the CSE level dropdown for each member in Step 1. If no CSE3+ is available for a CT meeting, you'll see an error toast.

**Solo meetings still show multiple roles**
Make sure the Solo toggle is checked for that specific meeting in Step 2. Note: if Containment Test is also checked, CT takes priority (always 3 roles). The Solo toggle is hidden when CT is active.

**Pins not working**
Expand the "📌 Pin" section under the meeting card in Step 2 and select a member for the desired role. Pinned members are assigned first before the algorithm fills remaining slots.

**Copy output doesn't match expected format**
Verify the correct format tab (Slack / OneNote / Markdown) is selected before clicking a Copy button. The `.txt` export always uses OneNote format regardless of the selected tab.

**History missing after update**
History is stored in localStorage, which is browser-specific and path-specific. If you moved the HTML file, renamed it, or switched browsers, previous history won't be accessible. History from Docker-hosted and file-opened versions are also separate.

**Fonts not loading**
DM Sans and JetBrains Mono are loaded from Google Fonts on first page load. If you're fully offline, the app falls back to system fonts. Everything still works — it just looks slightly different.

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for the full version history.

**v4.5.0** (Latest)
- Solo meeting support — new "Solo" role mode + per-meeting solo toggle
- Dynamic team size — add/remove members freely (minimum 1)
- Design revamp — DM Sans + JetBrains Mono, warm neutral palette, dark-first theme
- All previous bug fixes preserved

---

## Contributing

Issues and pull requests are welcome. The entire app is one HTML file, so contributing is as simple as editing `meeting_assigner.html` and testing in a browser.

When submitting changes, please:
1. Test all three copy formats (Slack, OneNote, Markdown)
2. Test with CT, Solo, and mixed-mode meetings
3. Verify the ICS export opens correctly in a calendar app
4. Check both dark and light themes

---

## License

[MIT](LICENSE) — Use it however you want.
