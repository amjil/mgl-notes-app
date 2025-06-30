# MGL Notes App

A Mongolian notes application developed with ClojureDart and Flutter.

## Features

### Multi-block Note Editor
- Support for editing multiple text blocks
- Horizontal scrolling ReorderableListView layout
- Focused block uses MongolTextField for editing
- Other blocks display using richtext-preview
- Support for drag and drop reordering of blocks
- Support for adding and deleting blocks
- Support for rich text link parsing (e.g., `[[note-name#block-id]]`)

## Tech Stack

- **ClojureDart**: Primary development language
- **Flutter**: UI framework
- **Mongol**: Mongolian text components
- **Isar**: Local database

## Development Environment Setup

1. Install Flutter SDK
2. Install ClojureDart
3. Clone the project
4. Run `flutter pub get` to install dependencies
5. Run `flutter run` to start the application

## Multi-block Editor Usage

### Basic Usage

```clojure
(block-editor/block-editor
 {:blocks [(create-block "block-1" "First block content")
           (create-block "block-2" "Second block content")]
  :on-blocks-changed (fn [new-blocks]
                      (println "Blocks updated:" new-blocks))
  :initial-focus-index 0})
```

### Feature Description

1. **Edit Mode**: Click any block to enter edit mode, use MongolTextField for editing
2. **Preview Mode**: Non-focused blocks display as rich text preview with link parsing support
3. **Drag and Drop**: Long press blocks to drag and reorder
4. **Add Block**: Click "Add Block" button to add a new block at the end
5. **Delete Block**: Click "Delete Block" button to delete the last block
6. **Save**: Click "Save" button to save the current note

### Link Format

Supports Wiki-style link format: `[[note-name#block-id]]`

- `[[note-name]]` - Link to specified note
- `[[note-name#block-id]]` - Link to specific block in specified note

## Project Structure

```
src/notes_app/
├── widgets/
│   ├── mgl_block_editor.cljd      # Multi-block note editor
│   ├── mgl_richtext_preview.cljd  # Rich text preview component
│   └── ...
├── screens/
│   └── home.cljd                  # Main screen
└── ...
```

## Development Notes

- Written in ClojureDart, compiled to Dart code
- Supports hot reload development
- Uses atoms for state management
- Responsive UI design
