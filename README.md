# MGL Notes App

A modern Mongolian notes application built with ClojureDart and Flutter, featuring a powerful multi-block editor and comprehensive note management system.

## 🆕 Recent Major Updates

- **Soft Delete & Restore**: Notes are now soft-deleted by default (not physically removed), with support for restore and permanent delete. All queries automatically exclude deleted notes. See usage examples below.
- **Calendar & Statistics**: The calendar bar now displays daily note counts with color indicators. User statistics (note count, tag count, active days, block count, link count) are tracked and persisted.
- **Diff-based Block Management**: Note editing uses a diff algorithm to efficiently update only changed blocks, reusing block IDs and improving performance and consistency.
- **Architecture Refactoring**: The database service layer now contains only single CRUD operations. All composite/business logic is in the states layer. All state functions that require context now take `ctx` as the first parameter. See [ARCHITECTURE_REFACTORING.md](ARCHITECTURE_REFACTORING.md) and [CTX_PARAMETER_DESIGN.md](CTX_PARAMETER_DESIGN.md) for details.

## 🚀 Features

### 📝 Multi-block Note Editor
- **Block-based editing**: Organize notes into multiple text blocks for better structure
- **Horizontal scrolling**: ReorderableListView layout for intuitive block navigation
- **Rich text support**: MongolTextField for focused editing with Mongolian text support
- **Preview mode**: Non-focused blocks display as rich text preview
- **Drag and drop**: Reorder blocks by long-pressing and dragging
- **Dynamic blocks**: Add and delete blocks as needed
- **Wiki-style links**: Support for rich text link parsing (e.g., `[[note-name#block-id]]`)
- **Diff-based block management**: Efficiently update only changed blocks using a diff algorithm

### 🎨 User Interface
- **Mongolian text support**: Full support for Mongolian language input and display
- **Responsive design**: Adapts to different screen sizes and orientations
- **Dark/Light themes**: Built-in theme switching capability
- **Custom fonts**: OnonSoninSans font for authentic Mongolian typography
- **Material Design**: Modern UI following Material Design principles

### 📊 Note Management
- **Local database**: Drift database for fast and reliable data storage
- **Search functionality**: Full-text search across all notes
- **Tag system**: Organize notes with custom tags
- **Filtering**: Filter notes by tags, date, or content
- **Infinite scroll**: Smooth scrolling for large note collections
- **Sync support**: Framework for future cloud synchronization
- **Soft delete & restore**: Soft delete notes, restore deleted notes, or permanently delete them
- **Deleted notes management**: View and manage deleted notes

### 🔧 Advanced Features
- **Virtual keyboard**: Custom Mongolian keyboard implementation
- **Auto-save**: Automatic saving of note changes
- **Export/Import**: Data backup and restore capabilities
- **Statistics**: Note usage analytics and insights (note count, tag count, active days, block count, link count)
- **Calendar integration**: Date-based note organization with daily note count indicators

## 🛠 Tech Stack

- **ClojureDart**: Primary development language for type-safe, functional programming
- **Flutter**: Cross-platform UI framework for native performance
- **Mongol**: Mongolian text components and input handling
- **Drift**: High-performance local database for data persistence
- **Shared Preferences**: Local settings and configuration storage

## 📦 Dependencies

### Core Dependencies
- `flutter`: ^3.8.1
- `mongol`: ^9.0.0
- `mongol_code`: ^0.3.0
- `drift`: ^2.27.0
- `sqlite3_flutter_libs`: ^0.5.34
- `shared_preferences`: ^2.5.3
- `uuid`: ^4.5.1
- `cupertino_icons`: ^1.0.8
- `lifecycle`: ^0.10.0
- `path`: ^1.9.0

### UI & UX
- `flutter_slidable`: ^4.0.0
- `flutter_styled_toast`: ^2.2.1
- `flutter_dotenv`: ^5.2.1

### Utilities
- `diff_match_patch`: ^0.4.1
- `vibration`: ^3.1.3
- `device_info_plus`: ^11.4.0
- `package_info_plus`: ^8.3.0
- `http`: ^1.4.0
- `path_provider`: ^2.1.4

### ClojureDart Dependencies (deps.edn)
- `tensegritics/clojuredart`
- `amjil/mongol-menu-bar`
- `amjil/mongol-virtual-keyboard`

## 🚀 Getting Started

### Prerequisites

1. **Flutter SDK** (^3.8.1)
2. **ClojureDart** (see https://github.com/Tensegritics/ClojureDart)
3. **Development Tools**: Android Studio / VS Code with Flutter extensions, Git

### Installation

1. **Clone the repository**
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Run the application**
   ```bash
   flutter run
   ```

### Development Commands

```bash
flutter run
flutter run --hot
flutter build apk
flutter build ios
flutter build web
flutter test
flutter analyze
```

## 📁 Project Structure

```
mgl-notes-app/
├── lib/                          # Dart entry point
│   ├── main.dart                 # Flutter app entry
│   ├── database/                 # Database schemas and generated code
│   │   ├── database.dart         # Database configuration
│   │   ├── database.g.dart       # Generated database code
│   │   └── connection/           # Database connection utilities
│   └── cljd-out/                 # ClojureDart output
├── src/notes_app/                # ClojureDart source code
│   ├── main.cljd                 # App entry point
│   ├── theme.cljd                # Theme configuration
│   ├── screens/                  # App screens
│   │   ├── home.cljd            # Main home screen
│   │   ├── import_export.cljd   # Import/export screen
│   │   ├── recycle.cljd         # Recycle bin screen
│   │   └── search.cljd          # Search screen
│   ├── widgets/                  # Reusable UI components
│   │   ├── mgl_app_bar.cljd     # Application bar
│   │   ├── mgl_calendar_bar.cljd # Calendar component
│   │   ├── mgl_chip.cljd        # Chip component
│   │   ├── mgl_drawer.cljd      # Navigation drawer
│   │   ├── mgl_editor_with_preview.cljd # Editor with preview
│   │   ├── mgl_empty_state.cljd # Empty state component
│   │   ├── mgl_filter_badge.cljd # Filter badge
│   │   ├── mgl_floating_editor.cljd # Floating editor
│   │   ├── mgl_import_export.cljd # Import/export widget
│   │   ├── mgl_infinite_scroll.cljd # Infinite scroll list
│   │   ├── mgl_input_editor.cljd # Input editor
│   │   ├── mgl_keyboard.cljd    # Virtual keyboard
│   │   ├── mgl_loading_state.cljd # Loading state
│   │   ├── mgl_menu_bar.cljd    # Menu bar
│   │   ├── mgl_note_editor.cljd # Multi-block editor
│   │   ├── mgl_note_item.cljd   # Note list item
│   │   ├── mgl_note_viewer.cljd # Note viewer
│   │   ├── mgl_notes_list.cljd  # Notes list view
│   │   ├── mgl_popup_menu.cljd  # Popup menu
│   │   ├── mgl_recycle_bin.cljd # Recycle bin widget
│   │   ├── mgl_richtext_viewer.cljd # Rich text viewer
│   │   ├── mgl_search_panel.cljd # Search panel
│   │   ├── mgl_setting.cljd     # Settings widget
│   │   ├── mgl_stats_widget.cljd # Statistics widget
│   │   ├── mgl_suggestion_panel.cljd # Suggestion panel
│   │   └── mgl_text_input.cljd  # Text input component
│   ├── states/                   # Application state management
│   │   ├── blocks.cljd          # Block state management
│   │   ├── calendar.cljd        # Calendar state
│   │   ├── links.cljd           # Link management state
│   │   ├── notes.cljd           # Notes state
│   │   ├── search.cljd          # Search state
│   │   ├── stats.cljd           # Statistics state
│   │   ├── tags.cljd            # Tags state
│   │   └── ui.cljd              # UI state management
│   ├── services/                 # Business logic
│   │   ├── common.cljd          # Common utilities
│   │   ├── db.cljd              # Database service
│   │   ├── env.cljd             # Environment configuration
│   │   ├── import_export.cljd   # Import/export service
│   │   ├── pref.cljd            # Preferences service
│   │   └── sync.cljd            # Synchronization service
│   └── utils/                    # Utility functions
│       ├── block.cljd           # Block utilities
│       ├── clipboard.cljd       # Clipboard utilities
│       ├── date.cljd            # Date utilities
│       ├── diff.cljd            # Diff algorithm utilities
│       ├── file.cljd            # File utilities
│       ├── navigator.cljd       # Navigation utilities
│       ├── span.cljd            # Text span utilities
│       ├── state_helpers.cljd   # State helper functions
│       ├── string.cljd          # String utilities
│       ├── tag.cljd             # Tag utilities
│       └── toast.cljd           # Toast notification utilities
├── assets/                       # Static assets
│   ├── fonts/                    # Custom fonts
│   └── data.zip                  # Sample data
├── server/                       # Server-side code
├── android/                      # Android-specific code
├── ios/                          # iOS-specific code
├── web/                          # Web-specific code
├── linux/                        # Linux-specific code
├── macos/                        # macOS-specific code
├── windows/                      # Windows-specific code
├── pubspec.yaml                  # Flutter dependencies
├── deps.edn                      # ClojureDart dependencies
└── README.md                     # Project documentation
```

## 🎯 Usage Guide

### Creating Notes

1. Open the app and tap the "+" button to create a new note
2. Add blocks by tapping "Add Block" to organize your content
3. Edit blocks by tapping on any block to enter edit mode
4. Reorder blocks by long-pressing and dragging
5. Changes are saved automatically as you type

### Using Wiki-style Links

- `[[note-name]]` - Link to a specific note
- `[[note-name#block-id]]` - Link to a specific block within a note

### Managing Tags

- Add tags to notes for better organization
- Filter notes by tags using the filter panel
- Search tags to find related notes quickly

### Search and Filter

- Full-text search across all notes and blocks
- Tag-based filtering for organized note browsing
- Date filtering to find notes by creation/update time

### Soft Delete, Restore, and Permanent Delete

- **Soft delete a note:**
  ```clojure
  ;; Soft delete (set isDeleted = true)
  (notes/delete-note! ctx note-id)
  ```
- **Restore a deleted note:**
  ```clojure
  ;; Restore a soft-deleted note
  (notes/restore-note! ctx note-id)
  ```
- **Permanently delete a note:**
  ```clojure
  ;; Hard delete (remove from database)
  (notes/hard-delete-note! ctx note-id)
  ```
- **List deleted notes:**
  ```clojure
  ;; Get deleted notes (paginated)
  (notes/load-deleted-notes! ctx page limit)
  ```

### Calendar and Statistics

- The calendar bar shows daily note counts with color indicators.
- User statistics (note count, tag count, active days, block count, link count) are automatically tracked and displayed.
- See [CALENDAR_FEATURE.md](CALENDAR_FEATURE.md) and [STATS_FEATURE.md](STATS_FEATURE.md) for details.

## 🔧 Development

### State Management & API Usage

- All state management functions that require context now take `ctx` as the first parameter:
  ```clojure
  (notes/create-note! ctx "Title")
  (notes/create-note-with-content! ctx content)
  (notes/update-note! ctx id title)
  (notes/delete-note! ctx id)
  ```
- See [CTX_PARAMETER_DESIGN.md](CTX_PARAMETER_DESIGN.md) and [STATE_MANAGEMENT_USAGE.md](STATE_MANAGEMENT_USAGE.md) for more details and examples.

### Database Architecture

- **Service Layer**: Only single CRUD operations (see `lib/services/database_service.dart`)
- **States Layer**: All composite/business logic (see `src/notes_app/states/`)
- **All state management functions call the database service through the states layer, not directly**
- See [ARCHITECTURE_REFACTORING.md](ARCHITECTURE_REFACTORING.md) for more details.

### Diff-based Block Management

- Note saving and editing uses a diff algorithm to efficiently update only changed blocks, reusing block IDs and improving performance and consistency.
- See [DIFF_INTEGRATION_CHANGES.md](DIFF_INTEGRATION_CHANGES.md) for technical details.

## 🧪 Testing

```bash
flutter test
flutter test integration_test/
flutter test --coverage
```

## 📱 Building for Production

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style

- Follow ClojureDart conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Write tests for new features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **ClojureDart Team** for the amazing ClojureDart framework
- **Flutter Team** for the excellent cross-platform framework
- **Mongol Package** for Mongolian text support


## 📞 Support

For support and questions:
- Create an issue on GitHub
- Check the documentation
- Review existing issues for solutions

---

**Built with ❤️ for the Mongolian community**
