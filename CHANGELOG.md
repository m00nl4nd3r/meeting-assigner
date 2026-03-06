# Changelog

## [5.2.0] — 2026-03-05

### Added
- **JSON export** — Export current assignment as `.json` from the results bar.
- **Full history backup** — "Backup All History (.json)" button in the history sidebar exports every saved run as a single timestamped JSON file.
- **JSON import** — Import backups or single assignments via file upload, drag-and-drop, or paste into the history sidebar. Detects format automatically (full backup vs single result). Deduplicates by ID.
- **Retroactive editing** — Loading a result from history and editing it saves changes back to that history entry in-place (no duplicate entries created).
- **Last edited tracking** — Every edit stamps `R.lastEdited` with an ISO timestamp. Shown in the results metadata bar, in the copy/export output header, and as a green dot on history entries.
- **Result metadata bar** — Shows generated date, last edited date, meeting counts, and active history index below the action buttons.
- **Drag-and-drop import** — Drop `.json` files directly onto the import zone in the history sidebar.
- **Reshuffle** — Re-run the algorithm with the same team, meetings, and Step 2 config but a fresh random shuffle. Available on Step 3 and on each history entry.
- **Edit Setup & Reassign** — Load a previous run's team and meetings back into the Step 1 wizard. Add or remove meetings, change members, adjust flags — then walk through Step 2 and regenerate. All Step 2 config (availability, PTO, pins, flags) is preserved.
- **History action buttons** — Each history entry now has View, Edit Setup, and Reshuffle buttons for quick access without loading first.
- **Setup persistence in results** — `R` now stores `originalMeetings` and `savedS2` so the full setup can be reconstructed for reshuffle and reload.

### Changed
- History entries now show "edited" date and a green dot indicator when they've been modified after generation.
- History cap raised to 50 for imports (20 for new generations).
- `clearHist()` resets `histIndex`.

## [5.1.0] — 2026-03-05

### Added
- **Internal meetings** — new 🏢 Internal flag in Step 2. Internal meetings have no roles assigned and appear in output as "(no roles assigned)". Checking Internal auto-clears CT and Solo flags.
- **Fair ceiling algorithm** — assignments now enforce `ceil(totalSlots / memberCount)` as a hard cap, preventing any member from being overloaded while others sit idle.
- **Role equity pass** — members who have never held a particular role get strong preference, spreading role variety across the team.

### Changed
- **Copy/paste completely rewritten** — removed Slack/OneNote/Markdown format toggle. Now one clean plain-text format that reads well everywhere (Slack, Teams, email, OneNote, docs). Solo meetings clearly tagged `[SOLO]` with "(prep, notes & follow-up)" label. Internal meetings tagged `[INTERNAL]`.
- **Algorithm sort order overhauled** — total balance now beats daily spread (fewest total assignments wins first). Fair ceiling check inserted as factor #2 after PTO. Pairing diversity demoted to tiebreaker.
- **Simplified results bar** — removed format toggle buttons. Copy All / Copy Assignments / Copy Stats + Export .txt / .ics.
- **Text export simplified** — no longer saves/restores format state since there's only one format.

### Fixed
- All v5.0.0 edge case fixes preserved (string IDs, isCSE3R parameter, ICS variable naming, Step 2 state preservation).

## [5.0.0] — 2026-03-03

### Added
- Complete ground-up rebuild from 7-session specification
- Multi-factor assignment algorithm
- Per-meeting Solo override, Containment Test flag
- 3 copy formats (Slack, OneNote, Markdown)
- Inline edit panel, ICS export, history sidebar, dark/light theme
