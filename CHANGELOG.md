# Changelog

All notable changes to Meeting Assigner will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.5.0] - 2024-12-12

### Added
- Stable sorting with alphabetical tiebreaker for deterministic results
- Pin indicators (📌) in Slack copy output
- Pin indicators in .txt export
- Pin indicators in calendar export descriptions
- Collapsible pin assignment UI (reduces visual clutter in Step 2)
- Docker healthcheck configuration
- Version display in application subtitle

### Changed
- Improved algorithm stability across different browsers
- Updated documentation with clearer PTO behavior explanation

### Fixed
- Sorting stability issue where equal candidates could produce inconsistent results

## [3.4.0] - 2024-12-10

### Added
- Pin Assignment feature - lock specific people to specific roles
- 📌 visual indicator for pinned assignments in results
- Validation for pin conflicts (can't pin unavailable members, can't double-pin)

### Changed
- Step 2 UI reorganized to accommodate pin controls

## [3.3.0] - 2024-12-08

### Added
- Per-meeting PTO tracking (not just whole-week)
- 🏖️ OOO indicator in tally display
- PTO status in Slack copy output
- Flexible partial-week PTO support

### Changed
- Algorithm now deprioritizes PTO members instead of excluding them
- PTO members get fewer meetings (no catch-up mechanism)

## [3.2.0] - 2024-12-05

### Added
- Configurable meeting duration for calendar export (15/30/45/60 minutes)
- Improved Slack formatting with role-specific emojis
- Export all members or individual to calendar

### Changed
- Simplified copy output format for better Slack rendering

## [3.1.0] - 2024-12-01

### Added
- Calendar export (.ics) for Outlook/Google Calendar
- Individual member calendar export with role in title
- Meeting duration selection

## [3.0.0] - 2024-11-28

### Added
- Dark mode with theme persistence
- Offline support (removed external dependencies)
- Self-contained single HTML file

### Changed
- Removed Google Fonts dependency
- All resources now embedded

### Fixed
- Works on air-gapped networks

## [2.0.0] - 2024-11-20

### Added
- 3 role configuration modes (1/2/3 people per meeting)
- History tracking with localStorage
- Export to .txt file
- Clear history confirmation modal

### Changed
- Complete UI redesign
- Improved mobile responsiveness

## [1.0.0] - 2024-11-15

### Added
- Initial release
- Basic meeting assignment for 3 team members
- Exemption checkboxes
- Copy to clipboard
- Simple tally display

---

## Upgrade Notes

### From 3.4.x to 3.5.0
No breaking changes. Pin indicators now appear in all export formats.

### From 3.3.x to 3.4.x
No breaking changes. New pin feature is optional.

### From 3.2.x to 3.3.x
No breaking changes. PTO feature is additive.

### From 2.x to 3.x
Theme preference will reset to light mode on first load.
History data is preserved.
