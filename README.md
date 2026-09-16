# Amjil Notes (`mgl_notes_app`)

Traditional Mongolian **vertical-script** notes app. Offline-first: write locally, sync later.

Built with **Flutter** (UI) and **ClojureDart** (app logic). Data lives in **Drift + SQLite**. Traditional Mongolian IME (virtual keyboard on mobile, desktop overlay) and fonts ship with the app.

Desktop is the primary target; mobile shares the same features via a drawer-based shell.

## Features

### Notes & daily journal

- **Today** — a daily note is created automatically for the current date (`YYYY-MM-DD`). Flip previous / next day, or jump back to today.
- **Activity heatmap** on Today (toggle in Settings; on by default).
- **Documents** — nested pages (parent / child). Drill into a folder-like list, create sub-documents, rename, move, or open the editor.
- Filter the document list to **calendar notes only**.
- **Soft delete** → **Trash**: restore or permanently delete (desktop side nav and mobile drawer).
- **Desktop split editors** — open multiple documents side by side; **Alt / Cmd / Ctrl+click** a document to open it in an adjacent pane.

### Block editor

Vertical Mongolian block editor with a toolbar (and slash-style block conversion). Block types are extended via app-level **plugins** (`image`, `attachment`, `flashcard`):

| Kind | Blocks |
| --- | --- |
| Text | paragraph, heading 1–3, quote, callout, toggle |
| Lists | bullet, numbered, **task** (checkbox) |
| Media | image (pick file, resize), attachment (open in external app) |
| Study | **flashcard** (question = block text; answer = child blocks) |
| Other | divider, web bookmark, **block embed** |

Paste or type a block reference `((uuid))` to transclude that block (read-only preview; tap to open the source document). **Copy Block Ref** puts `((uuid))` on the clipboard.

Hover a wiki link (~500ms) for a **preview popover** of the target note’s first blocks.

Edits auto-save after ~2 seconds; a final save runs when leaving the editor.

### Flashcards & spaced repetition

- Convert a block to **flashcard** from the toolbar / slash menu.
- Reveal the answer, then rate **Again / Hard / Good / Easy** (SM-2).
- Progress is stored on the block’s `data_json` (`repetition`, `interval`, `ease-factor`, `next-review-date`) — no separate table.
- Today shows a **due review** button with a count badge; open the deck to jump to each card’s source document.

### Wiki links, tags, backlinks

- `[[Title]]` wiki links and `#tags` are indexed locally from block text.
- Tap a link to open the target document, or create it if it does not exist.
- Editor sidebar: **linked references** and **unlinked mentions**; promote an unlinked mention to a real `[[Title]]` link.
- Dedicated **Tags** page: browse tags (note / mention counts), filter, open the tag page or jump to references.
- **Graph** view: force-directed map of wiki (and optional tag) links; zoom / drag nodes; click to open or create a document; highlight orphans.
- The link index is derived locally (not synced as operations). It is rebuilt after local saves and after pull.

### Tasks & search

- **Tasks** — all open (unchecked) todo blocks across documents; check them off or jump to the source note.
- **Search** — FTS5 full-text search over document titles and block text (`unicode61` tokenizer, bm25 ranking).

### Command palette & quick entry (desktop)

- **Cmd / Ctrl+K** — fuzzy search notes and blocks, or run `>` commands (`>sync`, `>new`, `>today`, `>trash`).
- **Alt+Space** — system-tray quick entry: transparent overlay; text appends as a new paragraph on **Today’s** note; Enter saves, Esc cancels. Closing the main window hides to the tray (Open / Quit from the tray menu). See [macOS native patches](#macos-native-patches-swift--re-apply-after-flutter-create--fresh-platform-dirs) after regenerating `macos/`.

### Images, attachments, export, backup

- Images and files are stored as **assets** (SHA-256, local path, upload/download status) and referenced from blocks.
- **Export HTML** — standalone vertical-script HTML plus the bundled `OyunQaganTig` font (from Today, the document list, or the editor).
- **Backup / restore** — export the local database (documents, blocks, assets, **operations**, `last_sync_time`) to JSON; import restores content and the sync log so a logged-in device does not re-push or miss ops. Legacy backups without an op log clear local operations and reset the pull cursor so the next sync reconciles with the cloud.

### Publish to Nomio

Nomio publishing is a separate optional account from cloud sync. It uses the
system browser with OAuth Authorization Code + PKCE and never asks for a Nomio
password inside the app. Configure builds with:

```bash
--dart-define=NOMIO_ISSUER=https://nomio.example.com
--dart-define=NOMIO_CLIENT_ID=mgl-notes-app
--dart-define=NOMIO_WEB_REDIRECT_URI=https://notes.example.com/oauth/callback
```

Native clients use `net.amjil.notes://oauth/callback`. Register every redirect
URI with Nomio before testing. The editor upload action creates and publishes an
article the first time, updates that article on later publishes, and uploads
local images first. Web credentials are scoped to browser session storage.
Linux packaging must include `libsecret-1-0` and install
`linux/net.amjil.notes.desktop` as the handler for the custom URI scheme.

#### Native platform changes for Nomio OAuth

The native runner changes below are required in every checkout because only
`src/` is synchronized by the application source workflow. Re-apply them after
regenerating Flutter platform directories.

**Android — `android/app/src/main/AndroidManifest.xml`**

- Disable Flutter's built-in deep-link handler for the activity:

```xml
<meta-data
    android:name="flutter_deeplinking_enabled"
    android:value="false" />
```

- Add this callback intent filter to `MainActivity`:

```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="net.amjil.notes"
        android:host="oauth"
        android:path="/callback" />
</intent-filter>
```

**iOS**

- In `ios/Runner/Info.plist`, register `net.amjil.notes` under
  `CFBundleURLTypes` with URL name `net.amjil.notes.oauth`.
- Set `FlutterDeepLinkingEnabled` to `false`; the `app_links` plugin owns
  callback delivery.
- Add `ios/Runner/Runner.entitlements` with an empty
  `keychain-access-groups` array so `flutter_secure_storage` can use Keychain.
- Set `CODE_SIGN_ENTITLEMENTS = Runner/Runner.entitlements` for Debug, Profile,
  and Release in `ios/Runner.xcodeproj/project.pbxproj`.

**macOS**

- In `macos/Runner/Info.plist`, register the `net.amjil.notes` URL scheme under
  `CFBundleURLTypes`.
- Add an empty `keychain-access-groups` array to both
  `macos/Runner/DebugProfile.entitlements` and
  `macos/Runner/Release.entitlements`.
- Keychain entitlements require a valid Apple development signature when
  building the runner.

**Windows — `windows/runner/main.cpp`**

- Include `app_links/app_links_plugin_c_api.h`.
- Before creating a new window, call `SendAppLink` when an existing
  `mgl_notes_app` window is found, then restore and focus that window.
- Register `net.amjil.notes` under
  `HKCU\Software\Classes\net.amjil.notes` with `URL Protocol` and an
  `"<executable>" "%1"` open command. The current implementation performs this
  registration at application startup.

**Linux**

- In `linux/runner/my_application.cc`, create the GTK application with
  `G_APPLICATION_HANDLES_COMMAND_LINE | G_APPLICATION_HANDLES_OPEN` so callback
  URIs are forwarded to `app_links`.
- Package and install `linux/net.amjil.notes.desktop`; it declares
  `MimeType=x-scheme-handler/net.amjil.notes` and launches
  `mgl_notes_app %U`.
- The build host needs `libsecret-1-dev`; the packaged application needs
  `libsecret-1-0`.

**Generated plugin registration**

After adding `app_links` and `flutter_secure_storage` to `pubspec.yaml`, run
`flutter pub get`. Flutter regenerates the Android, Apple, Linux, and Windows
plugin registrants; do not hand-edit generated registrant files.

### Account & sync (optional)

Works fully **offline**. Cloud sync is opt-in via Settings:

1. Turn on **Enable cloud sync**.
2. Set **Sync URL** (your sync service endpoint).
3. **Register** or **log in** (email + password; forgot / reset password).
4. **Sync now**, or let background sync run while the switch stays on.

Sync model (client):

- Local **operation log** is pushed; remote operations are pulled and applied (last-write-wins).
- Binary assets upload and download separately from the operation log.
- After edits: debounced **push** (~2s). **Pull** on launch, on resume, and every 5 minutes while logged in. **Push** on pause / background. Pull cursor is server ingest time (`received_at`), not the original edit time.

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

- Traditional Mongolian **vertical layout** (`mongol`) and **OyunQaganTig** font (additional fonts may ship under `assets/`).
- **Mobile**: in-app Mongolian virtual keyboard; **drawer** for Today / Documents / Tasks / Graph / Tags; Search in the AppBar; Trash and Settings as named routes.
- **Desktop**: global Mongolian IME overlay; left rail — Today → Documents → Tasks → Graph → Tags → Search → Trash → Settings; command palette and tray quick entry as above.
- Light parchment theme with sky-blue accents.

## Tech stack

- **Flutter**: cross-platform UI
- **ClojureDart (cljd)**: `.cljd` sources compiled to Dart
- **Drift + SQLite**: local persistence (FTS5 search index)
- **Mongolian**: `mongol`, bundled fonts + FST / IME assets

Local sibling packages (see `deps.edn`; keep them next to this repo):

| Package | Local path |
| --- | --- |
| `mgl-components` | `../mgl-components` |
| `mongol-virtual-keyboard` | `../monol-virtual-keyboard` |
| `mongol-ime` | `../mongol-ime` |
| `mgl-ime-core` | `../mgl-ime-core` |
| `mgl-block-editor` | `../mgl-block-editor` |
| `mgl-richtext-editor` | `../mgl-richtext-editor` |

## Repository layout (high level)

- `src/notes_app/` — ClojureDart sources  
  - entry: `notes-app.main` (`src/notes_app/main.cljd`)
  - `bootstrap/` — desktop & mobile boot
  - `desktop/` — shell, pages, widgets (side nav, command palette, keyboard)
  - `mobile/` — nav, pages, widgets (drawer)
  - `editor/` — editor view, bridge, link preview popover
  - `plugins/` — image, attachment, flashcard block plugins
  - `shared/` — Today, documents, graph, tags, tasks, search, trash, …
  - `services/` — documents, blocks, links, daily notes, sync, auth, assets, backup, export, SM-2
  - `db/` — Drift query helpers (including FTS and due flashcards)
  - `state/` — app UI store
- `lib/` — Dart / Flutter interop (Drift database)
  - `lib/database.dart`: tables + migrations
  - `lib/database.g.dart`: generated by Drift (do not edit)
- `assets/` — fonts, IME data, tray icons, app icon (`assets/icon/`)
- `tool/` — icon rendering scripts

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

### Web: inject IME / next-word API base URL

On Web, the Mongolian IME remote API base URL is read at **compile time** via `--dart-define`. If omitted, it falls back to the LAN default (`100.64.0.6:3003`).

```bash
clj -M:cljd flutter -d chrome \
  --dart-define=API_BASE_URL="https://your-api.example.com"
```

Same flag works with a plain Flutter build, e.g.:

```bash
flutter build web --dart-define=API_BASE_URL="https://your-api.example.com"
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

### macOS native patches (Swift) — re-apply after `flutter create` / fresh platform dirs

This repo’s synced tree is mainly `src/` + `lib/` (+ `README`, `pubspec`, assets under app control).
The `macos/` platform folder is **not** kept in sync, so after regenerating macOS runner files you must re-apply the two Swift edits below.
They are required for **system tray / Alt+Space quick-entry**: keep the process alive when the window hides, and allow a transparent Flutter window.

Also ensure desktop plugins are in `pubspec.yaml`:

```yaml
window_manager: ^0.5.2
hotkey_manager: ^0.2.3
tray_manager: ^0.5.3
```

Tray icons (already under assets if present): `assets/tray/icon.png`, `assets/tray/icon.ico` — declare them in `flutter.assets`.

After native changes, do a **full restart** (not hot restart):

```bash
clj -M:cljd flutter -d macos
```

#### 1. `macos/Runner/AppDelegate.swift`

Do **not** quit when the last window closes (close → hide to tray):

```swift
import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    // Keep alive for tray / global hotkey (Alt+Space quick entry).
    return false
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
```

**Change vs Flutter default:** `applicationShouldTerminateAfterLastWindowClosed` must return `false` (default template returns `true`).

#### 2. `macos/Runner/MainFlutterWindow.swift`

Clear the Flutter view background so `window_manager` transparency works in quick-entry mode:

```swift
import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    // Allow window_manager transparent backgrounds (quick-entry overlay).
    flutterViewController.backgroundColor = .clear
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
```

**Change vs Flutter default:** add `flutterViewController.backgroundColor = .clear` right after creating `FlutterViewController()`.

#### Checklist after regenerating `macos/`

1. Apply the two Swift files above.
2. `flutter pub get` (and confirm `window_manager` / `hotkey_manager` / `tray_manager` are present).
3. Confirm tray assets are listed in `pubspec.yaml`.
4. Full relaunch on macOS; grant **Accessibility** if prompted (global Alt+Space hotkey).

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

## App icon

Master artwork is the square `assets/icon/app_icon.png` (vector: `assets/icon/app_icon.svg`). iOS, Android, and Web keep that square so the OS can apply its own mask. macOS, Windows, and Linux need the shape baked into the PNG.

After changing the master, regenerate platform-shaped variants, then launcher icons:

```bash
python3 tool/render_platform_icons.py
dart run flutter_launcher_icons
```

## Database notes

Drift tables: `documents`, `blocks`, `operations`, `assets`, `block_links`.

- **Schema version**: `4` (`lib/database.dart`).
- **FTS5** virtual table `search_index` (`tokenize61`), kept in sync with documents/blocks via triggers; search uses `MATCH` + bm25.
- Flashcard SM-2 state lives in **`blocks.data_json`**, not a separate table.
- **Native (Android/iOS/macOS/Windows/Linux)**: SQLite file is created in the app documents directory as `mgl_notes.db` (see `lib/connection/native.dart`).
- **Web**: uses Drift WASM (`sqlite3.wasm` + `drift_worker.js`, see `lib/connection/web.dart`).
- **Schema & migrations**: `schemaVersion` and the migration strategy are defined in `lib/database.dart`.

## License

MIT. See `LICENSE`.
