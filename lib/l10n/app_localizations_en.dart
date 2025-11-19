// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mongol Notes App';

  @override
  String get drawerLogin => 'Login';

  @override
  String get drawerLogout => 'Logout';

  @override
  String get drawerAbout => 'About';

  @override
  String get drawerRecycle => 'Recycle Bin';

  @override
  String get drawerSettings => 'Settings';

  @override
  String get loginHeading => 'Login';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginSubmit => 'Login';

  @override
  String get loginSubmitting => 'Logging in...';

  @override
  String get loginSuccess => 'Login successful';

  @override
  String get loginError => 'Login failed';

  @override
  String get loginRegisterCta => 'Register';

  @override
  String get registerHeading => 'Register';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerPasswordLabel => 'Password (≥6 chars)';

  @override
  String get registerConfirmLabel => 'Confirm password';

  @override
  String get registerSubmit => 'Register';

  @override
  String get registerSubmitting => 'Registering...';

  @override
  String get registerSuccess => 'Registration successful. Please log in';

  @override
  String get registerError => 'Registration failed';

  @override
  String get registerLoginCta => 'Login';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSubtitle => 'Choose display language';

  @override
  String get languageDialogTitle => 'Select language';

  @override
  String get languageSystem => 'Follow system';

  @override
  String get languageMongolian => 'Mongolian';

  @override
  String get languageMongolianTraditional => 'Traditional Mongolian';

  @override
  String get languageChinese => 'Chinese';

  @override
  String get languageEnglish => 'English';

  @override
  String get dialogClose => 'Close';

  @override
  String get aboutFeaturesTitle => 'Features';

  @override
  String get aboutFeatureCreateEdit => 'Create and edit notes';

  @override
  String get aboutFeatureOrganize => 'Organize notes by categories';

  @override
  String get aboutFeatureUi => 'Beautiful and intuitive UI';

  @override
  String get aboutDescriptionTitle => 'App Description';

  @override
  String get aboutDescriptionBody =>
      'A modern note-taking application built with Flutter and ClojureDart. Features include creating, editing, and organizing notes with a beautiful user interface.';

  @override
  String get aboutDeveloperTitle => 'Developer';

  @override
  String get aboutDeveloperBody =>
      'Built with ❤️ using Flutter and ClojureDart';

  @override
  String get aboutVersionLabel => 'Version 1.0.0';

  @override
  String get helpHeaderTitle => 'Help & Support';

  @override
  String get helpHeaderSubtitle => 'Get help with using the app';

  @override
  String get helpGettingStartedTitle => 'Getting Started';

  @override
  String get helpCreateNotesTitle => 'Create Notes';

  @override
  String get helpCreateNotesDescription =>
      'Tap the + button to create a new note. You can add text, organize with tags, and save your thoughts.';

  @override
  String get helpSearchTitle => 'Search & Find';

  @override
  String get helpSearchDescription =>
      'Use the search icon to find specific notes by text content or tags.';

  @override
  String get helpOrganizeTitle => 'Organize';

  @override
  String get helpOrganizeDescription =>
      'Use tags and categories to keep your notes organized and easy to find.';

  @override
  String get helpCommonIssuesTitle => 'Common Issues';

  @override
  String get helpSyncTitle => 'Sync Issues';

  @override
  String get helpSyncDescription =>
      'If notes aren\'t syncing, check your internet connection and try refreshing the app.';

  @override
  String get helpSaveTitle => 'Save Problems';

  @override
  String get helpSaveDescription =>
      'Notes auto-save as you type. If you\'re having issues, try closing and reopening the note.';

  @override
  String get helpImportExportTitle => 'Import/Export';

  @override
  String get helpImportExportDescription =>
      'Use the floating action button to import notes from other apps or export your data.';

  @override
  String get helpContactSupportTitle => 'Contact Support';

  @override
  String get helpEmailSupportTitle => 'Email Support';

  @override
  String get helpEmailSupportDescription =>
      'Send us an email at support@notesapp.com for technical assistance.';

  @override
  String get helpReportBugsTitle => 'Report Bugs';

  @override
  String get helpReportBugsDescription =>
      'Found a bug? Use the bug report feature in the settings menu.';

  @override
  String get helpFeedbackTitle => 'Feedback';

  @override
  String get helpFeedbackDescription =>
      'We\'d love to hear your suggestions for improving the app.';

  @override
  String get helpUserAccountTitle => 'User Account & Data';

  @override
  String get helpLoginMigrationTitle => 'Login & Data Migration';

  @override
  String get helpLoginMigrationDescription =>
      'When you log in, all notes created in anonymous mode will automatically become part of your account. Your previous anonymous data will be transferred to your user account.';

  @override
  String get helpLogoutAccessTitle => 'Logout & Data Access';

  @override
  String get helpLogoutAccessDescription =>
      'After logging out, you will not be able to access your notes. You must log in again to view and manage your data.';

  @override
  String get helpUserOnlyTitle => 'User-Only Access';

  @override
  String get helpUserOnlyDescription =>
      'All notes are tied to your user account. You must be logged in to create, view, search, and manage your notes.';

  @override
  String get helpAppLockSectionTitle => 'App Lock & Security';

  @override
  String get helpAppLockFeatureTitle => 'App Lock';

  @override
  String get helpAppLockFeatureDescription =>
      'App Lock protects your notes with a password. Once enabled, the app will automatically lock after a period of inactivity.';

  @override
  String get helpAppLockWarningTitle => 'Important Warning';

  @override
  String get helpAppLockWarningDescription =>
      '⚠️ CRITICAL: If you forget your unlock password, you will permanently lose access to ALL your data. There is no password recovery option. Please remember your password carefully!';

  @override
  String get helpAppLockAutoTitle => 'Auto Lock';

  @override
  String get helpAppLockAutoDescription =>
      'You can set an auto-lock timeout. The app will automatically lock after the specified time of inactivity.';

  @override
  String get helpFaqTitle => 'Frequently Asked Questions';

  @override
  String get helpFaqBackupQuestion => 'Q: How do I backup my notes?';

  @override
  String get helpFaqBackupAnswer =>
      'A: Use the export feature in the floating action button to backup your notes.';

  @override
  String get helpFaqOfflineQuestion => 'Q: Can I use the app offline?';

  @override
  String get helpFaqOfflineAnswer =>
      'A: Yes! Notes are saved locally and will sync when you\'re back online.';
}
