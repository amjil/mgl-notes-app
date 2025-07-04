# MGL Notes App

A modern Mongolian notes application built with ClojureDart and Flutter, featuring a powerful multi-block editor and comprehensive note management system.

## 🚀 Features

### 📝 Multi-block Note Editor
- **Block-based editing**: Organize notes into multiple text blocks for better structure
- **Horizontal scrolling**: ReorderableListView layout for intuitive block navigation
- **Rich text support**: MongolTextField for focused editing with Mongolian text support
- **Preview mode**: Non-focused blocks display as rich text preview
- **Drag and drop**: Reorder blocks by long-pressing and dragging
- **Dynamic blocks**: Add and delete blocks as needed
- **Wiki-style links**: Support for rich text link parsing (e.g., `[[note-name#block-id]]`)

### 🎨 User Interface
- **Mongolian text support**: Full support for Mongolian language input and display
- **Responsive design**: Adapts to different screen sizes and orientations
- **Dark/Light themes**: Built-in theme switching capability
- **Custom fonts**: OnonSoninSans font for authentic Mongolian typography
- **Material Design**: Modern UI following Material Design principles

### 📊 Note Management
- **Local database**: Isar database for fast and reliable data storage
- **Search functionality**: Full-text search across all notes
- **Tag system**: Organize notes with custom tags
- **Filtering**: Filter notes by tags, date, or content
- **Infinite scroll**: Smooth scrolling for large note collections
- **Sync support**: Framework for future cloud synchronization

### 🔧 Advanced Features
- **Virtual keyboard**: Custom Mongolian keyboard implementation
- **Auto-save**: Automatic saving of note changes
- **Export/Import**: Data backup and restore capabilities
- **Statistics**: Note usage analytics and insights
- **Calendar integration**: Date-based note organization

## 🛠 Tech Stack

- **ClojureDart**: Primary development language for type-safe, functional programming
- **Flutter**: Cross-platform UI framework for native performance
- **Mongol**: Mongolian text components and input handling
- **Isar**: High-performance local database for data persistence
- **Drift**: Type-safe database access layer
- **Shared Preferences**: Local settings and configuration storage

## 📦 Dependencies

### Core Dependencies
- `flutter`: ^3.8.1 - UI framework
- `mongol`: ^9.0.0 - Mongolian text components
- `mongol_code`: ^0.3.0 - Mongolian code input
- `drift`: ^2.27.0 - Database ORM
- `sqlite3_flutter_libs`: ^0.5.34 - SQLite support
- `shared_preferences`: ^2.5.3 - Local storage
- `uuid`: ^4.5.1 - Unique identifier generation

### UI & UX
- `flutter_slidable`: ^4.0.0 - Swipeable list items
- `flutter_styled_toast`: ^2.2.1 - Toast notifications
- `flutter_dotenv`: ^5.2.1 - Environment configuration

### Utilities
- `diff_match_patch`: ^0.4.1 - Text diffing
- `vibration`: ^3.1.3 - Haptic feedback
- `device_info_plus`: ^11.4.0 - Device information
- `package_info_plus`: ^8.3.0 - App metadata
- `http`: ^1.4.0 - HTTP client
- `path_provider`: ^2.1.4 - File system access

## 🚀 Getting Started

### Prerequisites

1. **Flutter SDK** (^3.8.1)
   ```bash
   flutter --version
   ```

2. **ClojureDart**
   ```bash
   # Install ClojureDart
   # Follow instructions at https://github.com/Tensegritics/ClojureDart
   ```

3. **Development Tools**
   - Android Studio / VS Code with Flutter extensions
   - Git for version control

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd mgl-notes-app
   ```

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
# Run in debug mode
flutter run

# Run with hot reload
flutter run --hot

# Build for release
flutter build apk
flutter build ios
flutter build web

# Run tests
flutter test

# Analyze code
flutter analyze
```

## 📁 Project Structure

```
mgl-notes-app/
├── lib/                          # Dart entry point
│   ├── main.dart                 # Flutter app entry
│   ├── database.dart             # Database initialization
│   ├── models/                   # Data models
│   ├── services/                 # Business logic services
│   ├── providers/                # State providers
│   └── database/                 # Database schemas
├── src/notes_app/                # ClojureDart source code
│   ├── main.cljd                 # App entry point
│   ├── theme.cljd                # Theme configuration
│   ├── screens/                  # App screens
│   │   └── home.cljd            # Main home screen
│   ├── widgets/                  # Reusable UI components
│   │   ├── mgl_note_editor.cljd # Multi-block editor
│   │   ├── mgl_notes_list.cljd  # Notes list view
│   │   ├── mgl_calendar_bar.cljd # Calendar component
│   │   └── ...                  # Other UI components
│   ├── states/                   # Application state management
│   │   ├── app.cljd             # Global app state
│   │   ├── notes.cljd           # Notes state
│   │   ├── database.cljd        # Database operations
│   │   └── ...                  # Other state modules
│   ├── services/                 # Business logic
│   │   ├── common.cljd          # Common utilities
│   │   ├── pref.cljd            # Preferences service
│   │   └── env.cljd             # Environment configuration
│   └── utils/                    # Utility functions
├── assets/                       # Static assets
│   ├── fonts/                    # Custom fonts
│   └── data.zip                  # Sample data
├── android/                      # Android-specific code
├── ios/                          # iOS-specific code
├── web/                          # Web-specific code
├── linux/                        # Linux-specific code
├── macos/                        # macOS-specific code
├── windows/                      # Windows-specific code
├── pubspec.yaml                  # Flutter dependencies
└── deps.edn                      # ClojureDart dependencies
```

## 🎯 Usage Guide

### Creating Notes

1. **Open the app** and tap the "+" button to create a new note
2. **Add blocks** by tapping "Add Block" to organize your content
3. **Edit blocks** by tapping on any block to enter edit mode
4. **Reorder blocks** by long-pressing and dragging
5. **Save automatically** - changes are saved as you type

### Using Wiki-style Links

The app supports Wiki-style linking between notes:

- `[[note-name]]` - Link to a specific note
- `[[note-name#block-id]]` - Link to a specific block within a note

### Managing Tags

1. **Add tags** to notes for better organization
2. **Filter notes** by tags using the filter panel
3. **Search tags** to find related notes quickly

### Search and Filter

- **Full-text search** across all notes and blocks
- **Tag-based filtering** for organized note browsing
- **Date filtering** to find notes by creation/update time

## 🔧 Development

### State Management

The app uses a unified state management approach with ClojureDart atoms:

```clojure
;; Example state structure
(def app-state
  (atom {:notes []
         :current-note nil
         :search-query ""
         :selected-tags #{}
         :theme :light}))
```

### Database Operations

Database operations are handled through the Drift ORM:

```clojure
;; Example database query
(defn get-notes []
  (db/query-notes db-instance))

;; Example database insert
(defn save-note [note]
  (db/insert-note db-instance note))
```

### Adding New Features

1. **Create widgets** in `src/notes_app/widgets/`
2. **Add state management** in `src/notes_app/states/`
3. **Implement services** in `src/notes_app/services/`
4. **Update screens** in `src/notes_app/screens/`

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run with coverage
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
- **Isar Team** for the high-performance database

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Check the documentation
- Review existing issues for solutions

---

**Built with ❤️ for the Mongolian community**
