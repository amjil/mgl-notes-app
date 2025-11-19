import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_mn.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('mn'),
    Locale.fromSubtags(languageCode: 'mn', scriptCode: 'Mong'),
    Locale('zh'),
  ];

  /// Application title shown in system task switcher.
  ///
  /// In en, this message translates to:
  /// **'Mongol Notes App'**
  String get appTitle;

  /// Drawer action label for logging in.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get drawerLogin;

  /// No description provided for @drawerLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get drawerLogout;

  /// No description provided for @drawerAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get drawerAbout;

  /// No description provided for @drawerRecycle.
  ///
  /// In en, this message translates to:
  /// **'Recycle Bin'**
  String get drawerRecycle;

  /// No description provided for @drawerSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get drawerSettings;

  /// No description provided for @loginHeading.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginHeading;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginSubmit.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginSubmit;

  /// No description provided for @loginSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loginSubmitting;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccess;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginError;

  /// No description provided for @loginRegisterCta.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get loginRegisterCta;

  /// No description provided for @registerHeading.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerHeading;

  /// No description provided for @registerEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registerEmailLabel;

  /// No description provided for @registerPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password (≥6 chars)'**
  String get registerPasswordLabel;

  /// No description provided for @registerConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get registerConfirmLabel;

  /// No description provided for @registerSubmit.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerSubmit;

  /// No description provided for @registerSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Registering...'**
  String get registerSubmitting;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful. Please log in'**
  String get registerSuccess;

  /// No description provided for @registerError.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registerError;

  /// No description provided for @registerLoginCta.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get registerLoginCta;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose display language'**
  String get settingsLanguageSubtitle;

  /// No description provided for @languageDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get languageDialogTitle;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get languageSystem;

  /// No description provided for @languageMongolian.
  ///
  /// In en, this message translates to:
  /// **'Mongolian'**
  String get languageMongolian;

  /// No description provided for @languageMongolianTraditional.
  ///
  /// In en, this message translates to:
  /// **'Traditional Mongolian'**
  String get languageMongolianTraditional;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get languageChinese;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @dialogClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get dialogClose;

  /// No description provided for @aboutFeaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get aboutFeaturesTitle;

  /// No description provided for @aboutFeatureCreateEdit.
  ///
  /// In en, this message translates to:
  /// **'Create and edit notes'**
  String get aboutFeatureCreateEdit;

  /// No description provided for @aboutFeatureOrganize.
  ///
  /// In en, this message translates to:
  /// **'Organize notes by categories'**
  String get aboutFeatureOrganize;

  /// No description provided for @aboutFeatureUi.
  ///
  /// In en, this message translates to:
  /// **'Beautiful and intuitive UI'**
  String get aboutFeatureUi;

  /// No description provided for @aboutDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'App Description'**
  String get aboutDescriptionTitle;

  /// No description provided for @aboutDescriptionBody.
  ///
  /// In en, this message translates to:
  /// **'A modern note-taking application built with Flutter and ClojureDart. Features include creating, editing, and organizing notes with a beautiful user interface.'**
  String get aboutDescriptionBody;

  /// No description provided for @aboutDeveloperTitle.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get aboutDeveloperTitle;

  /// No description provided for @aboutDeveloperBody.
  ///
  /// In en, this message translates to:
  /// **'Built with ❤️ using Flutter and ClojureDart'**
  String get aboutDeveloperBody;

  /// No description provided for @aboutVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get aboutVersionLabel;

  /// No description provided for @helpHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpHeaderTitle;

  /// No description provided for @helpHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get help with using the app'**
  String get helpHeaderSubtitle;

  /// No description provided for @helpGettingStartedTitle.
  ///
  /// In en, this message translates to:
  /// **'Getting Started'**
  String get helpGettingStartedTitle;

  /// No description provided for @helpCreateNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Notes'**
  String get helpCreateNotesTitle;

  /// No description provided for @helpCreateNotesDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to create a new note. You can add text, organize with tags, and save your thoughts.'**
  String get helpCreateNotesDescription;

  /// No description provided for @helpSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search & Find'**
  String get helpSearchTitle;

  /// No description provided for @helpSearchDescription.
  ///
  /// In en, this message translates to:
  /// **'Use the search icon to find specific notes by text content or tags.'**
  String get helpSearchDescription;

  /// No description provided for @helpOrganizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Organize'**
  String get helpOrganizeTitle;

  /// No description provided for @helpOrganizeDescription.
  ///
  /// In en, this message translates to:
  /// **'Use tags and categories to keep your notes organized and easy to find.'**
  String get helpOrganizeDescription;

  /// No description provided for @helpCommonIssuesTitle.
  ///
  /// In en, this message translates to:
  /// **'Common Issues'**
  String get helpCommonIssuesTitle;

  /// No description provided for @helpSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync Issues'**
  String get helpSyncTitle;

  /// No description provided for @helpSyncDescription.
  ///
  /// In en, this message translates to:
  /// **'If notes aren\'t syncing, check your internet connection and try refreshing the app.'**
  String get helpSyncDescription;

  /// No description provided for @helpSaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Save Problems'**
  String get helpSaveTitle;

  /// No description provided for @helpSaveDescription.
  ///
  /// In en, this message translates to:
  /// **'Notes auto-save as you type. If you\'re having issues, try closing and reopening the note.'**
  String get helpSaveDescription;

  /// No description provided for @helpImportExportTitle.
  ///
  /// In en, this message translates to:
  /// **'Import/Export'**
  String get helpImportExportTitle;

  /// No description provided for @helpImportExportDescription.
  ///
  /// In en, this message translates to:
  /// **'Use the floating action button to import notes from other apps or export your data.'**
  String get helpImportExportDescription;

  /// No description provided for @helpContactSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get helpContactSupportTitle;

  /// No description provided for @helpEmailSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Support'**
  String get helpEmailSupportTitle;

  /// No description provided for @helpEmailSupportDescription.
  ///
  /// In en, this message translates to:
  /// **'Send us an email at support@notesapp.com for technical assistance.'**
  String get helpEmailSupportDescription;

  /// No description provided for @helpReportBugsTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Bugs'**
  String get helpReportBugsTitle;

  /// No description provided for @helpReportBugsDescription.
  ///
  /// In en, this message translates to:
  /// **'Found a bug? Use the bug report feature in the settings menu.'**
  String get helpReportBugsDescription;

  /// No description provided for @helpFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get helpFeedbackTitle;

  /// No description provided for @helpFeedbackDescription.
  ///
  /// In en, this message translates to:
  /// **'We\'d love to hear your suggestions for improving the app.'**
  String get helpFeedbackDescription;

  /// No description provided for @helpUserAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'User Account & Data'**
  String get helpUserAccountTitle;

  /// No description provided for @helpLoginMigrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Login & Data Migration'**
  String get helpLoginMigrationTitle;

  /// No description provided for @helpLoginMigrationDescription.
  ///
  /// In en, this message translates to:
  /// **'When you log in, all notes created in anonymous mode will automatically become part of your account. Your previous anonymous data will be transferred to your user account.'**
  String get helpLoginMigrationDescription;

  /// No description provided for @helpLogoutAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout & Data Access'**
  String get helpLogoutAccessTitle;

  /// No description provided for @helpLogoutAccessDescription.
  ///
  /// In en, this message translates to:
  /// **'After logging out, you will not be able to access your notes. You must log in again to view and manage your data.'**
  String get helpLogoutAccessDescription;

  /// No description provided for @helpUserOnlyTitle.
  ///
  /// In en, this message translates to:
  /// **'User-Only Access'**
  String get helpUserOnlyTitle;

  /// No description provided for @helpUserOnlyDescription.
  ///
  /// In en, this message translates to:
  /// **'All notes are tied to your user account. You must be logged in to create, view, search, and manage your notes.'**
  String get helpUserOnlyDescription;

  /// No description provided for @helpAppLockSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'App Lock & Security'**
  String get helpAppLockSectionTitle;

  /// No description provided for @helpAppLockFeatureTitle.
  ///
  /// In en, this message translates to:
  /// **'App Lock'**
  String get helpAppLockFeatureTitle;

  /// No description provided for @helpAppLockFeatureDescription.
  ///
  /// In en, this message translates to:
  /// **'App Lock protects your notes with a password. Once enabled, the app will automatically lock after a period of inactivity.'**
  String get helpAppLockFeatureDescription;

  /// No description provided for @helpAppLockWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Important Warning'**
  String get helpAppLockWarningTitle;

  /// No description provided for @helpAppLockWarningDescription.
  ///
  /// In en, this message translates to:
  /// **'⚠️ CRITICAL: If you forget your unlock password, you will permanently lose access to ALL your data. There is no password recovery option. Please remember your password carefully!'**
  String get helpAppLockWarningDescription;

  /// No description provided for @helpAppLockAutoTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto Lock'**
  String get helpAppLockAutoTitle;

  /// No description provided for @helpAppLockAutoDescription.
  ///
  /// In en, this message translates to:
  /// **'You can set an auto-lock timeout. The app will automatically lock after the specified time of inactivity.'**
  String get helpAppLockAutoDescription;

  /// No description provided for @helpFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get helpFaqTitle;

  /// No description provided for @helpFaqBackupQuestion.
  ///
  /// In en, this message translates to:
  /// **'Q: How do I backup my notes?'**
  String get helpFaqBackupQuestion;

  /// No description provided for @helpFaqBackupAnswer.
  ///
  /// In en, this message translates to:
  /// **'A: Use the export feature in the floating action button to backup your notes.'**
  String get helpFaqBackupAnswer;

  /// No description provided for @helpFaqOfflineQuestion.
  ///
  /// In en, this message translates to:
  /// **'Q: Can I use the app offline?'**
  String get helpFaqOfflineQuestion;

  /// No description provided for @helpFaqOfflineAnswer.
  ///
  /// In en, this message translates to:
  /// **'A: Yes! Notes are saved locally and will sync when you\'re back online.'**
  String get helpFaqOfflineAnswer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'mn', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'mn':
      {
        switch (locale.scriptCode) {
          case 'Mong':
            return AppLocalizationsMnMong();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'mn':
      return AppLocalizationsMn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
