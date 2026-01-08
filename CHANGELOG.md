# Changelog

## [4.0.0] - 2025-01-08

### Added
- **CSE Levels**: Assign CSE2, CSE3, or CSE4 to each team member
- **Containment Tests**: Special 2-person meetings (Lead + Follow-up) requiring CSE3+ as Lead
- **Daily Spread Algorithm**: Prioritizes balancing meetings across days, not just total count
- CSE level badges displayed throughout the UI
- Warning when CSE3+ unavailable for containment tests

### Changed
- Renamed to "CST Meeting Assigner" (Concierge Security Team)
- Default role mode changed to 2-person
- Algorithm now considers daily meeting count before total count
- Container renamed to `cst-meeting-assigner`

### Technical
- Refactored JavaScript for smaller file size
- Improved sorting stability with multi-level tiebreakers

---

## [3.5.0] - 2024-12-12

### Added
- Stable sorting with alphabetical tiebreaker
- Pin indicators in Slack copy and exports
- Collapsible pin assignment UI

---

## [3.4.0] - 2024-12-10

### Added
- Pin Assignment feature

---

## [3.3.0] - 2024-12-08

### Added
- Per-meeting PTO tracking
- PTO members get fewer meetings (no catch-up)

---

## [3.2.0] - 2024-12-05

### Added
- Configurable meeting duration for calendar export
- Improved Slack formatting

---

## [3.0.0] - 2024-11-28

### Added
- Dark mode
- Offline support
- Single HTML file architecture
