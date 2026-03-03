# Changelog

All notable changes to the CST Meeting Assigner.

## [5.0.0] — 2026-03-03

### Added
- Complete ground-up rebuild from 7-session specification
- Multi-factor assignment algorithm (PTO, daily spread, pairing diversity, role/total balance)
- Per-meeting Solo override (independent of global role mode)
- Containment Test flag with CSE3+ Presenter enforcement
- 3 copy formats: Slack, OneNote, Markdown (v4.7.0 scannable design)
- Inline edit panel with duplicate/CSE validation
- ICS calendar export with per-member filtering and configurable duration
- History sidebar with localStorage persistence (max 20 entries)
- Dark/light theme with warm neutral palette and CSS custom properties
- Step 2 state preservation across step transitions
- Pin system for locking members to specific roles
- Toast notification system with auto-dismiss
- Responsive layout with 880px max-width container

### Fixed
- ICS variable shadowing (uses distinct loop variable names)
- Text export saves/restores format state correctly
- CT toggle preserves Step 2 checkbox state
- Meeting IDs coerced to strings for object key lookups
- `isCSE3R()` accepts levels parameter for algorithm inner loop
- Assignments panel renders before Stats panel in all contexts

## [4.7.0] — Previous

### Changed
- Scannable copy format: one line per meeting with emoji role icons
- Compact stats with non-zero-only role counts
- Solo meetings inline in copy output
