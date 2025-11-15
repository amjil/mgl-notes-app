# MGL Notes App

A Mongolian-first note-taking experience built with ClojureDart and Flutter. The app combines vertical Mongolian typography, a block-based editor, sync-ready persistence, and modern UX patterns to help writers collect, organize, and revisit ideas.

## Highlights (2025-11)

- **Favorite shelf**: horizontal favorites list in the drawer with quick navigation and unfavorite actions.
- **Inline note references**: `[[Linked Note]]` titles now form references that open inside the editor and keep cross-note relationships in sync.
- **Automatic tag extraction**: hashtags inside blocks are promoted to structured tags, reused across search and filtering.
- **Upgraded search surface**: unified panel (notes + tags), suggestions, infinite scroll, and filter badges for tag/date context.
- **Electric Sync adapters**: upload / pull helpers (`notes_app/utils/sync.cljd`) plus login & registration hooks ready to integrate with an Electric backend.
- **State helpers refresh**: pagination, toast, and loading primitives reused across lists for consistent feedback.

## Feature Overview

- **Block-based editor** with Mongolian vertical input, reordering, and block-level persistence.
- **Favorites** pinned inside the app drawer for one-tap recall.
- **Tagging** via inline `#hashtags`, automatic creation, and tag-note associations.
- **Search workspace** covering notes, tags, and suggestions with pagination and custom keyboard support.
- **Recycle Bin** for soft delete + restore with paginated history.
- **Import / Export** JSON snapshots with quick share/delete actions.
- **Authentication screens** (login & register) wired to Electric Sync auth APIs.
- **Offline-first storage** using Drift, with sync markers to reconcile local ↔ remote.
- **Custom Mongolian keyboard & fonts** bundled for vertical script typing on any platform.

## Tech Stack

- **Flutter** UI with Material 3 theming and lifecycle hooks.
- **ClojureDart** business logic compiled to Dart (`lib/cljd-out/`).
- **Drift** for local relational storage, FTS indices, and reactive queries.
- **Electric Sync** integration points (auth, token, push/pull) for multi-device sync.
- **Mongol / mongol_code** packages for vertical text components.
- **Shared Preferences & Path Provider** for lightweight persistence and file IO.

## Getting Started

### Prerequisites

1. Dart SDK ≥ 3.8.1
2. Flutter (stable channel)
3. Clojure CLI & ClojureDart toolchain (`clojure -M:cljd`)
4. macOS/Linux shell capable of running the above tools

### Installation

```bash
git clone <repository-url>
cd mgl-notes-app
flutter pub get
clojure -M:cljd
flutter pub run build_runner build
flutter run
```

> Tip: run `flutter pub run build_runner build --delete-conflicting-outputs` after schema changes.

### Environment Variables

`src/notes_app/services/env.cljd` exposes `base-utl` for Electric endpoints. If you switch to `.env` files, load them via `flutter_dotenv` before bootstrapping the app.

## Common Workflows

- **Develop**: `flutter run` (emulator or device).
- **Unit test**: `flutter test`.
- **Analyze**: `flutter analyze`.
- **Build release**:
  - Android APK: `flutter build apk --release`
  - Android App Bundle: `flutter build appbundle --release`
  - iOS: `flutter build ios --release`
  - Web: `flutter build web --release`
- **Regenerate ClojureDart output**: `clojure -M:cljd`.
- **Regenerate Drift artifacts**: `flutter pub run build_runner build`.

## Synchronization Hooks

`notes_app/utils/sync.cljd` provides four entry points:
- `upload-pending-notes!`
- `upload-pending-blocks!`
- `pull-notes-from-server!`
- `pull-blocks-from-server!`

Pair these with scheduling (app lifecycle, background isolates, or manual triggers) once an Electric Sync backend is live. Successful pushes mark rows as `synced` and keep block FTS tables updated.

Authentication helpers in `notes_app/services/auth.cljd` call `electric-sync.auth` for login/registration, update local user IDs, and refresh note feeds post-auth.

## Import & Export

`notes_app/services/import_export.cljd` exports complete note bundles—blocks, tags, metadata—to JSON files under `~/Documents/exports`. UI actions in `import_export.cljd` allow sharing or deleting those bundles. Import routines handle recreating notes, blocks, and tag associations.

## Project Structure (snapshot)

```
mgl-notes-app/
├── lib/
│   ├── main.dart
│   ├── cljd-out/            # Generated Dart from Clojure sources
│   └── database/            # Drift database + generated files
├── src/notes_app/
│   ├── main.cljd            # App entry + route table
│   ├── theme.cljd           # Light/Dark theme definitions
│   ├── screens/             # Home, editor, search, recycle, auth, about, help
│   ├── widgets/             # Mongolian UI components (chips, lists, favorites, etc.)
│   ├── states/              # Atoms & pagination helpers for notes/search/tags/ui
│   ├── services/            # DB, auth, env, import/export
│   └── utils/               # Blocks, tags, clipboard, navigator, sync, toast
├── assets/
│   ├── fonts/               # Mongolian fonts bundled in pubspec
│   ├── data.zip             # Keyboard dictionary
│   └── next.zip             # Next-candidate dictionary
├── pubspec.yaml             # Flutter + Dart dependencies
├── deps.edn                 # ClojureDart dependencies
└── README.md
```

## Development Guidelines

- Favor semantic naming in both ClojureDart and Dart outputs.
- Keep long-running operations async and wrap UI mutations with loading/toast helpers.
- Add drift migrations/tests when evolving persistent models.
- Contributions: fork → branch → commit (`feat: ...`) → PR.

## License

MIT License. See `LICENSE` for the full text.

---

Built for Mongolian note-takers with ❤️.
