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
}
