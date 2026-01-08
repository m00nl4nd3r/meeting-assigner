# CST Meeting Assigner

Fair meeting role assignment for Concierge Security Teams (CST).

[![Version](https://img.shields.io/badge/Version-4.0.0-green.svg)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)](https://www.docker.com/)

---

## Quick Start

```bash
git clone https://github.com/m00nl4nd3r/meeting-assigner.git
cd meeting-assigner
docker compose up -d
# Open http://localhost
```

Or just open `meeting_assigner.html` directly in any browser.

---

## What's New in v4.0.0

- **CSE Levels** — Assign CSE2, CSE3, or CSE4 to each team member
- **Containment Tests** — Special 2-person meetings requiring CSE3+ as Lead
- **Daily Spread Algorithm** — Balances meetings across days, not just total count
- **Renamed to CST Meeting Assigner** — Tailored for Concierge Security Teams

---

## How to Use

1. **Enter team members** with their CSE level (CSE2, CSE3, CSE4)
2. **Add meetings** for each day (Mon-Fri)
3. **Review & set exemptions:**
   - 🔒 **Containment Test** — Requires CSE3+ as Lead
   - 📌 **Pin Assignment** — Lock someone to a role
   - ☑️ **Available** — Uncheck if unavailable
   - 🏖️ **PTO** — Fewer meetings, no catch-up
4. **Generate** — Assignments spread evenly across days
5. **Export** — Slack, .txt, or .ics calendar

---

## Key Features

| Feature | Description |
|---------|-------------|
| **CSE Levels** | CSE2, CSE3, CSE4 designations for each team member |
| **Containment Tests** | 2-person meetings (Lead + Follow-up) requiring CSE3+ Lead |
| **Daily Spread** | Balances meetings per day to avoid overloading specific days |
| **PTO Support** | PTO members get fewer meetings — no catch-up required |
| **Pin Assignments** | Lock specific people to roles when needed |
| **Fair Distribution** | Algorithm ensures equal workload across the week |
| **Dark Mode** | Light/dark theme toggle |
| **Offline** | Works without internet |

---

## Containment Tests (Active Response Tests)

Containment tests are special meetings that require:
- **2 people**: Lead + Follow-up
- **CSE3+ as Lead**: Only CSE3 or CSE4 can lead these calls
- **30 minutes max**: Default duration in calendar export

**If your team's CSE3+ is on PTO:**
The tool will warn you to pull in a CSE3/4 from another CST team. The meeting cannot proceed without a CSE3+ present.

**Typical team compositions:**
- 1 CSE3 + 2 CSE2s
- 1 CSE4 + 2 CSE3s

---

## Daily Spread Algorithm

The algorithm prioritizes spreading meetings evenly across days:

```
Sort candidates by:
1. PTO status (non-PTO preferred)
2. Meetings TODAY (fewer = higher priority)  ← NEW
3. Role count (fewer = higher priority)
4. Total count (fewer = higher priority)
5. Alphabetical tiebreaker
```

**Example:**
- Alice has 3 meetings on Monday, Bob has 1
- Next Monday meeting → Bob gets it (even if Alice has fewer total)

This prevents one person from being overloaded on a single day.

---

## PTO Behavior

**PTO = fewer meetings, no catch-up.**

When someone is marked 🏖️ OOO:
- They're deprioritized (non-PTO members assigned first)
- They get fewer meetings that week
- **No make-up next week** — each week stands alone

---

## Deployment

### Docker (Recommended)

```bash
docker compose up -d
# Access at http://localhost
```

### Change Port

Edit `docker-compose.yml`:
```yaml
ports:
  - "8080:80"
```

### No Docker

Open `meeting_assigner.html` directly in your browser.

---

## File Structure

```
meeting-assigner/
├── meeting_assigner.html    # The application
├── Dockerfile               # Docker config
├── docker-compose.yml       # Compose config
├── deploy.sh                # Deploy script
├── README.md                # This file
├── CHANGELOG.md             # Version history
├── LICENSE                  # MIT License
└── .gitignore
```

---

## Technical Details

### Role Configurations

| Mode | Roles | Notes |
|------|-------|-------|
| 1 Person | Owner | One person handles everything |
| 2 People | Presenter + Follow-up | Default mode |
| 3 People | Prep + Presenter + Follow-up | Full separation |
| Containment Test | Lead + Follow-up | Always 2-person, CSE3+ Lead required |

### CSE Levels

| Level | Can Lead Containment Tests? | Typical Count per Team |
|-------|----------------------------|------------------------|
| CSE2 | ❌ No | 2 |
| CSE3 | ✅ Yes | 1 |
| CSE4 | ✅ Yes | 0-1 |

### Storage

- `meetingHistory` — Past assignments (localStorage)
- `theme` — Light/dark preference (localStorage)

---

## Slack Copy Format

```
📅 *CST WEEKLY ASSIGNMENTS*

📅 *MONDAY*
• *Customer Review*
  🎤 Presenter: Alice (CSE3)
  ✅ Follow-up: Bob (CSE2)

• *Acme Containment Test* 🔒
  🎯 Lead: Alice (CSE3) 📌
  ✅ Follow-up: Charlie (CSE2)
```

---

## Troubleshooting

### "No CSE3+ available for Containment Test"
Your team's CSE3/4 is unavailable. Pull in help from another CST team.

### Port 80 in use
```bash
# Change port in docker-compose.yml
ports:
  - "8080:80"
```

### Changes not showing
Hard refresh: `Ctrl+Shift+R` / `Cmd+Shift+R`

---

## Contributing

1. Fork the repo
2. Edit `meeting_assigner.html`
3. Test all features (containment tests, PTO, daily spread)
4. Submit PR

---

## License

MIT License — see [LICENSE](LICENSE)

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md)

**Current: v4.0.0**
- CSE levels (CSE2, CSE3, CSE4)
- Containment Test support
- Daily spread algorithm
- Renamed to CST Meeting Assigner
