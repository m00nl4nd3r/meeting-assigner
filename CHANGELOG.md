# Changelog

All notable changes to CST Meeting Assigner.

## [4.5.0] — 2025-02-13

### Added
- **Solo meeting support** — New "Solo" role mode assigns only a Presenter
- **Per-meeting solo toggle** — Override any meeting to solo in Step 2 (hidden when CT is active)
- **Dynamic team size** — Add or remove team members freely, minimum 1
- Solo indicators in all copy formats (Slack: `👤 _Solo_`, OneNote: `[Solo]`, Markdown: `[Solo]`)
- Solo indicator (👤) in ICS calendar export titles
- Solo count in history summaries

### Changed
- Minimum team size reduced from 3 to 1
- Role mode selector now shows 3 options: Solo / 2 People / 3 People
- 2-person mode validates ≥2 members, 3-person validates ≥3
- CT toggle now explicitly clears solo flag (CT always takes priority)
- Version bumped to 4.5.0

## [4.4.0] — 2025-02-10

### Added
- Complete UI/UX revamp with DM Sans + JetBrains Mono typography
- Warm neutral color palette with terracotta accent
- Dark-first theme with polished light mode
- Pairing matrix table in tally section
- Card entry animations and hover effects
- Per-member CSE level badges with color coding
- Toast notifications for all actions

### Fixed
- ICS export variable shadowing (`a` used for both loop var and download link)
- Copy formats skipping zero-count roles (now always shows all roles)
- CT toggle destroying all Step 2 checkbox state (now preserves availability/PTO/pins)
- TXT export not restoring format selector after export
- `isCSE3Plus` referencing input state instead of results state
- OneNote "Copy All" using wrong separator

### Changed
- Simplified role structure: Presenter, Notes, Follow-up
- Dynamic team member inputs (add/remove freely)
- Compact CSS class names for smaller file size
- Refined dark mode contrast and color variables

## [4.3.2] — 2025-01-15

### Fixed
- String vs number meeting ID lookups — all `data-*` attributes now cast to string
- Pins, exemptions, PTO, and CT flags no longer silently fail

## [4.3.1] — 2025-01-10

### Fixed
- Pairing tally calculation for edited assignments
- Edit validation allowing duplicate members

## [4.3.0] — 2025-01-05

### Added
- Calendar export (.ics) with member filter and duration control
- Export to .txt file with date-stamped filename
- History persistence with localStorage (max 20 entries)

## [4.2.0] — 2024-12-20

### Added
- Inline edit with recalculation
- Edit indicators on modified roles
- Containment Test toggle per meeting

## [4.1.0] — 2024-12-10

### Added
- Multi-format copy system (Slack, OneNote, Markdown)
- Copy Tally, Copy Assignments, Copy All buttons
- PTO soft-deprioritize flag

## [4.0.0] — 2024-12-01

### Added
- Initial release with 2/3 person role modes
- Multi-factor assignment algorithm
- Pin assignments feature
- Availability checkboxes per meeting
- Daily tally and pairing counts
