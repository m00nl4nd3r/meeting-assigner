# Meeting Assigner

A self-contained web application for fair weekly meeting role assignment across team members.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)](https://www.docker.com/)
[![Version](https://img.shields.io/badge/Version-3.5.0-green.svg)](CHANGELOG.md)

---

## Quick Start (30 Seconds)

### Option 1: Docker (Recommended)
```bash
git clone https://github.com/m00nl4nd3r/meeting-assigner.git
cd meeting-assigner
docker compose up -d
# Open http://localhost
```

### Option 2: Direct Use
Just open `meeting_assigner.html` in any browser. No server required.

---

## How to Use

1. **Choose role structure** — 1, 2, or 3 people per meeting
2. **Enter team members** — Your 3 team member names
3. **Add meetings** — Paste meetings into each day (Mon-Fri)
4. **Set exemptions** (optional):
   - 📌 **Pin** — Lock someone to a specific role
   - ☑️ **Available** — Uncheck if someone can't attend
   - 🏖️ **PTO** — Check if someone is off (they get fewer meetings — no make-up required)
5. **Generate** — Click "Confirm & Assign"
6. **Export** — Copy to Slack, download .txt, or export to calendar

---

## Features

| Feature | Description |
|---------|-------------|
| **Fair Distribution** | Equal workload across available team members |
| **Flexible Roles** | 1-person, 2-person, or 3-person configurations |
| **Per-Meeting PTO** | Mark OOO for specific meetings — **PTO = fewer meetings, no catch-up** |
| **Pin Assignments** | Lock specific people to specific roles |
| **Dark Mode** | Light/dark theme toggle |
| **Calendar Export** | .ics files for Outlook/Google Calendar |
| **Slack-Ready Copy** | Formatted with emojis 📋 |
| **History** | View past assignments |
| **Offline** | Works without internet |
| **Zero Dependencies** | Single HTML file, no build step |

---

## Table of Contents

- [Deployment](#deployment)
- [Technical Documentation](#technical-documentation)
- [Feature Deep-Dives](#feature-deep-dives)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## Deployment

### Docker Compose (Recommended)

```bash
git clone https://github.com/m00nl4nd3r/meeting-assigner.git
cd meeting-assigner
docker compose up -d
```

Access at **http://localhost**

### Docker Direct

```bash
docker build -t meeting-assigner .
docker run -d -p 80:80 --name meeting-assigner --restart unless-stopped meeting-assigner
```

### Deploy Script

```bash
chmod +x deploy.sh
./deploy.sh
```

### Change Port

Edit `docker-compose.yml`:
```yaml
ports:
  - "8080:80"  # Now accessible at http://localhost:8080
```

### No Docker

Just open `meeting_assigner.html` directly in your browser. Done.

---

## Technical Documentation

### Architecture

```
meeting_assigner.html (Single File ~125KB)
├── <style>
│   ├── CSS Variables (theming)
│   ├── Light/Dark mode definitions
│   ├── Responsive layouts
│   └── Component styles
├── <body>
│   ├── Dark mode toggle
│   ├── Role configuration (1/2/3 person)
│   ├── Step 1: Input (members, meetings)
│   ├── Step 2: Exemptions (pins, availability, PTO)
│   ├── Step 3: Results (tally, assignments)
│   ├── Export controls
│   └── History section
└── <script>
    ├── State management
    ├── Assignment algorithm
    ├── Rendering functions
    ├── Export functions
    └── localStorage persistence
```

### Assignment Algorithm

```
FOR each meeting (shuffled for randomness):
    1. Get available members (not exempted)
    2. FOR each role:
        a. If role is PINNED → assign pinned person
        b. Else:
           - Filter out already-used members
           - Sort candidates by:
             1. PTO status (non-PTO preferred)
             2. Role count (lowest first)
             3. Total count (lowest first)  
             4. Alphabetical (tiebreaker for determinism)
           - Assign top candidate
    3. Update tallies
```

**Critical PTO Behavior:** 

PTO members are **deprioritized**, not excluded. The algorithm prefers non-PTO members, which naturally results in PTO members getting fewer meetings. **There is no catch-up or make-up mechanism.** If Alice is on PTO Monday-Tuesday, she gets fewer meetings that week — and that's correct and fair.

```javascript
// Sorting logic (simplified)
candidates.sort((a, b) => {
    // 1. Prefer non-PTO
    if (aIsPTO && !bIsPTO) return 1;   // b wins
    if (!aIsPTO && bIsPTO) return -1;  // a wins
    
    // 2. Lowest role count wins
    if (tally[a][role] !== tally[b][role]) 
        return tally[a][role] - tally[b][role];
    
    // 3. Lowest total wins
    if (tally[a].Total !== tally[b].Total)
        return tally[a].Total - tally[b].Total;
    
    // 4. Alphabetical tiebreaker
    return a.localeCompare(b);
});
```

### State Management

```javascript
// Global state object
state = {
    members: ['Alice', 'Bob', 'Charlie'],
    allMeetings: [
        { id: 0, day: 'Mon', name: 'Customer Review', original: 'Mon: Customer Review' },
        { id: 1, day: 'Mon', name: 'Sprint Planning', original: 'Mon: Sprint Planning' },
        // ...
    ],
    roleMode: 2,  // 1, 2, or 3
    ptoStatus: {
        0: ['Alice'],  // Meeting ID 0: Alice is on PTO
        1: ['Alice'],  // Meeting ID 1: Alice is on PTO
    }
}

// Results object (saved to history)
currentResults = {
    id: '2024-01-15T10:30:00.000Z',
    date: '1/15/2024, 10:30:00 AM',
    tally: {
        'Alice': { Presenter: 2, 'Follow-up': 2, Total: 4 },
        'Bob': { Presenter: 4, 'Follow-up': 3, Total: 7 },
        'Charlie': { Presenter: 3, 'Follow-up': 4, Total: 7 }
    },
    assignments: [
        {
            day: 'Mon',
            name: 'Customer Review',
            roles: { Presenter: 'Bob', 'Follow-up': 'Charlie' },
            pinned: { Presenter: 'Bob' }
        }
    ],
    members: ['Alice', 'Bob', 'Charlie'],
    roleMode: 2,
    roleLabels: ['Presenter', 'Follow-up'],
    ptoMembers: ['Alice'],
    ptoStatus: { 0: ['Alice'], 1: ['Alice'] }
}
```

### Storage

| Key | Purpose | Location |
|-----|---------|----------|
| `meetingHistory` | Array of past results | localStorage |
| `theme` | `'light'` or `'dark'` | localStorage |

Data persists per browser/device. No server-side storage.

### Key Functions

| Function | Purpose |
|----------|---------|
| `renderExemptionUI()` | Builds Step 2 with pins, availability, PTO checkboxes |
| `confirmAssignButton` handler | Collects inputs, runs algorithm, renders results |
| `renderTally()` | Displays counts with PTO indicators |
| `renderAssignments()` | Shows role assignments with pin indicators |
| `exportToCalendar()` | Generates .ics files |
| `copyToClipboard()` | Slack-formatted copy with fallback |
| `escapeHTML()` | XSS prevention |
| `shuffleArray()` | Fisher-Yates shuffle for randomness |

### Docker Setup

```dockerfile
FROM nginx:alpine
COPY meeting_assigner.html /usr/share/nginx/html/index.html
# Permissions fixed for nginx user
EXPOSE 80
```

Image size: ~25MB

---

## Feature Deep-Dives

### Role Configurations

| Mode | Roles | Description |
|------|-------|-------------|
| **1 Person** | Owner | One person handles prep, presentation, notes, follow-up |
| **2 People** | Presenter, Follow-up | Presenter preps and presents; Follow-up takes notes and follows up |
| **3 People** | Prep, Presenter, Follow-up | Full separation of duties |

### PTO (Out of Office) Feature

**The key principle: PTO means fewer meetings, not make-up meetings.**

When you mark someone as 🏖️ OOO:
- They're **deprioritized** (non-PTO members assigned first)
- They **can still be assigned** if necessary
- They **get fewer meetings** — this is correct behavior
- **No catch-up next week** — each week stands alone

**Example scenario:**
```
Week with 18 meetings total:
- Alice: PTO Monday-Tuesday (marked OOO for 6 meetings)
- Bob: Working full week
- Charlie: Working full week

Expected result:
- Alice: ~5 meetings (Wed-Fri only)
- Bob: ~6-7 meetings
- Charlie: ~6-7 meetings

Alice having fewer meetings is CORRECT. She was only available 3 days.
```

**Per-meeting granularity:**
- Half-day PTO? Mark only morning meetings
- Conference on Thursday? Mark only Thursday meetings
- Different team members with different PTO? No problem

### Pin Assignment Feature

Lock specific people to specific roles.

**Use cases:**
- Project owner presents their own project
- Manager always runs team standup
- Account owner presents to their client
- SME leads technical discussion

**How to use:**
1. In Step 2, click to expand 📌 Pin Assignment
2. Select person from dropdown for desired role
3. Leave as "-- Auto Assign --" for algorithm to decide

**Rules:**
- Pinned person must be marked as Available
- Can't pin same person to multiple roles in one meeting
- Pinned assignments count toward tallies

**Visual indicator:** 📌 appears next to pinned assignments in results and exports

### Calendar Export

**Supported calendars:** Outlook, Google Calendar, Apple Calendar, any iCal-compatible app

**Options:**
- All team members (combined view)
- Individual member (filtered to their assignments)
- Duration: 15, 30, 45, or 60 minutes

**Generated .ics includes:**
- Meeting name as title
- Role assignments in description
- Pin indicators
- Individual role in title when exporting for one person

### Slack Formatting

Copy buttons produce markdown that renders beautifully in Slack:

**Tally output:**
```
📊 *ASSIGNMENT TALLY*

*Alice 🏖️ (OOO):* Presenter: 2, Follow-up: 3 (Total: 5)
*Bob:* Presenter: 4, Follow-up: 3 (Total: 7)
*Charlie:* Presenter: 3, Follow-up: 3 (Total: 6)
```

**Assignments output:**
```
📅 *WEEKLY MEETING ASSIGNMENTS*

📅 *MONDAY*
• *Customer Review*
  🎤 Presenter: Bob 📌
  ✅ Follow-up: Charlie

• *Sprint Planning*
  🎤 Presenter: Charlie
  ✅ Follow-up: Bob
```

**Emoji reference:**
| Emoji | Meaning |
|-------|---------|
| 📊 | Tally section |
| 📅 | Day header |
| 👤 | Owner (1-person mode) |
| 📋 | Prep (3-person mode) |
| 🎤 | Presenter |
| ✅ | Follow-up |
| 📌 | Pinned assignment |
| 🏖️ | On PTO |

---

## Troubleshooting

### 403 Forbidden (Docker)

```bash
docker compose down
docker compose build --no-cache
docker compose up -d
```

### Port 80 in Use

```bash
# Find what's using port 80
sudo lsof -i :80

# Or change port in docker-compose.yml
ports:
  - "8080:80"
```

### Container Not Accessible

```bash
docker ps                        # Check if running
docker logs meeting-assigner     # Check for errors
docker port meeting-assigner     # Verify port mapping
```

### Changes Not Showing

- Hard refresh: `Ctrl+Shift+R` / `Cmd+Shift+R`
- Clear browser cache
- Rebuild: `docker compose build --no-cache`

### History Lost

History lives in browser localStorage. Cleared when you:
- Clear browser data
- Switch browsers
- Use incognito/private mode

---

## File Structure

```
meeting-assigner/
├── meeting_assigner.html    # The application (single file)
├── Dockerfile               # Docker image config
├── docker-compose.yml       # Docker Compose config
├── deploy.sh                # Deployment script
├── README.md                # This documentation
├── CHANGELOG.md             # Version history
├── LICENSE                  # MIT License
└── .gitignore               # Git ignore rules
```

---

## Contributing

1. Fork the repo
2. Create feature branch: `git checkout -b feature/my-feature`
3. Edit `meeting_assigner.html`
4. Test in browser and Docker
5. Commit: `git commit -m 'Add feature'`
6. Push: `git push origin feature/my-feature`
7. Open Pull Request

**Guidelines:**
- Keep everything in one HTML file
- No external dependencies
- Test all role modes
- Test dark mode
- Test edge cases (all PTO, all pinned, etc.)

---

## License

MIT License — see [LICENSE](LICENSE)

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

**Current: v3.5.0**

---

Made for teams who share meeting responsibilities fairly. 🤝
