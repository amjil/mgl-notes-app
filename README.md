# Amjil Notes (`mgl_notes_app`)

Traditional Mongolian **vertical-script** notes app. Offline-first: write locally, sync later.

Built with **Flutter** (UI) and **ClojureDart** (app logic). Data lives in **Drift + SQLite**. Traditional Mongolian IME (virtual keyboard on mobile, desktop overlay) and fonts ship with the app.

V1 targets **desktop**; mobile has a working shell (bottom nav) and will be polished later.

## Features

### Notes & daily journal

- **Today** — a daily note is created automatically for the current date (`YYYY-MM-DD`). Flip previous / next day, or jump back to today.
- **Documents** — nested pages (parent / child). Drill into a folder-like list, create sub-documents, rename, move, or open the editor.
- Filter the document list to **calendar notes only**.
- **Soft delete** → **Trash** (desktop): restore or permanently delete. Trash is not on the mobile tab bar yet.

### Block editor

Vertical Mongolian block editor with a toolbar (and slash-style block conversion):

| Kind | Blocks |
| --- | --- |
| Text | paragraph, heading 1–3, quote, callout, toggle |
| Lists | bullet, numbered, **task** (checkbox) |
| Media | image (pick file, resize), attachment (open in external app) |
| Other | divider, web bookmark, **block embed** |

Paste or type a block reference `((uuid))` to transclude that block (read-only preview; tap to open the source document). **Copy Block Ref** puts `((uuid))` on the clipboard.

Edits auto-save after ~2 seconds; a final save runs when leaving the editor.

### Wiki links, tags, backlinks

- `[[Title]]` wiki links and `#tags` are indexed locally from block text.
- Tap a link to open the target document, or create it if it does not exist.
- Editor sidebar: **linked references** and **unlinked mentions**; promote an unlinked mention to a real `[[Title]]` link.
- The link index is derived locally (not synced as operations). It is rebuilt after local saves and after pull.

### Tasks & search

- **Tasks** — all open (unchecked) todo blocks across documents; check them off or jump to the source note.
- **Search** — debounced search over document titles and block text.

### Images, attachments, export, backup

- Images and files are stored as **assets** (SHA-256, local path, upload/download status) and referenced from blocks.
- **Export HTML** — standalone vertical-script HTML plus the bundled `OyunQaganTig` font (from Today, the document list, or the editor).
- **Backup / restore** — export the local database (documents, blocks, assets, **operations**, `last_sync_time`) to JSON; import restores content and the sync log so a logged-in device does not re-push or miss ops. Legacy backups without an op log clear local operations and reset the pull cursor so the next sync reconciles with the cloud.

### Account & sync (optional)

Works fully **offline**. Cloud sync is opt-in via Settings:

1. Turn on **Enable cloud sync**.
2. Set **Sync URL** (your sync service endpoint).
3. **Register** or **log in** (email + password; forgot / reset password).
4. **Sync now**, or let background sync run while the switch stays on.

Sync model (client):

- Local **operation log** is pushed; remote operations are pulled and applied (last-write-wins).
- Binary assets upload and download separately from the operation log.
- After edits: debounced **push** (~2s). **Pull** on launch, on resume, and every 5 minutes while logged in. **Push** on pause / background.

#### Title conflicts (same note, different devices)

A common case: two devices both have sync **off**, each writes the same daily journal for today, then both turn sync **on**. Each device created its own document with the same title (e.g. `2026-08-24`) but a different internal id — the “same file name, different baseline” problem.

**Rule:** the copy that **syncs first** keeps the original title. The later copy is **auto-renamed**; nothing is deleted.

| Step | What happens |
| --- | --- |
| Push (second device) | Cloud sync sees title `2026-08-24` already taken → the incoming document keeps its id but the title becomes `2026-08-24 (device bbbb conflict copy)` (`bbbb` = last 4 characters of that device’s id). The app updates the local title to match. |
| Pull (local duplicate) | When applying a remote create, if this device already has a different document with the same title → the **local** copy is renamed to the conflict title first, then the remote (winning) copy is inserted with the original title. |

**Example**

- Device A syncs first → `2026-08-24` stays on A and in the cloud.
- Device B syncs later → B’s note becomes `2026-08-24 (device bbbb conflict copy)` on B and in the cloud.
- Both notes appear in the document list (or Today, if daily). Open each and merge content manually — e.g. copy blocks from the conflict copy into the canonical note, then delete the copy when done.

**Design trade-off:** logic is simple and **data is never dropped**; you may need to clean up conflict copies yourself after sync. Applies to any document title clash in the workspace, not only daily notes.

After sync, the app shows a **SnackBar** when a rename happened (e.g. `Title conflict: "2026-08-24" was renamed to "…". Open both notes to merge.`).

### Input & UI

- Traditional Mongolian **vertical layout** (`mongol`) and **OyunQaganTig** font.
- **Mobile**: in-app Mongolian virtual keyboard.
- **Desktop**: global Mongolian IME overlay.
- Dark theme. Desktop uses a left rail; mobile uses a bottom bar (Today / Docs / Tasks / Search / Settings).

## Tech stack

- **Flutter**: cross-platform UI
- **ClojureDart (cljd)**: `.cljd` sources compiled to Dart
- **Drift + SQLite**: local persistence
- **Mongolian**: `mongol`, bundled fonts + FST / IME assets

Local sibling repos (see `deps.edn`): `mgl-components`, `mongol-virtual-keyboard`, `mongol-ime`, `mgl-ime-core`, `mgl-block-editor`, `mgl-richtext-editor`.

## Repository layout (high level)

- `src/notes_app/`: ClojureDart sources  
  - entry: `notes-app.main` (`src/notes_app/main.cljd`)
  - `pages/`: Today, documents, editor, tasks, search, trash, settings, desktop/mobile shells
  - `services/`: documents, blocks, links, daily notes, sync, auth, assets, backup, export
- `lib/`: Dart / Flutter interop (Drift database)
  - `lib/database.dart`: tables + migrations
  - `lib/database.g.dart`: generated by Drift (do not edit)
- `assets/`: fonts + IME data

## Prerequisites

- **Flutter SDK** (matching your local toolchain)
- **Clojure CLI** (`clj`)
- **ClojureDart** via `deps.edn` alias `:cljd`
- Sibling local packages listed above (same parent directory)

## Setup

Install Dart/Flutter deps:

```bash
flutter pub get
```

Initialize the ClojureDart/Flutter wiring (safe to re-run):

```bash
clj -M:cljd init
```

## Development

### Run with hot reload (recommended)

This runs `flutter run` while watching and recompiling `.cljd` files:

```bash
clj -M:cljd flutter
```

You can pass any `flutter run` flags after it, for example:

```bash
clj -M:cljd flutter -d macos
```

### Compile / watch (without launching Flutter)

```bash
clj -M:cljd compile
clj -M:cljd watch
```

### Clean build artifacts

```bash
clj -M:cljd clean
flutter clean
```

## Drift code generation

This project uses Drift’s generator for `lib/database.g.dart`.

One-off build:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Watch mode:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Database notes

Tables: `documents`, `blocks`, `operations`, `assets`, `block_links`.

- **Native (Android/iOS/macOS/Windows/Linux)**: SQLite file is created in the app documents directory as `mgl_notes.db` (see `lib/connection/native.dart`).
- **Web**: uses Drift WASM (`sqlite3.wasm` + `drift_worker.js`, see `lib/connection/web.dart`).
- **Schema & migrations**: `schemaVersion` is defined in `lib/database.dart` along with the migration strategy.

## License

MIT. See `LICENSE`.
