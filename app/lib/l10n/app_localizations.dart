import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'App Name'**
  String get app_name;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome_back;

  /// No description provided for @login_to_your_account.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get login_to_your_account;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @enter_register_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email'**
  String get enter_register_email;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_password;

  /// No description provided for @proceed_to_login.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Login'**
  String get proceed_to_login;

  /// No description provided for @enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enter_your_name;

  /// No description provided for @enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_your_email;

  /// No description provided for @proceed_to_register.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Register'**
  String get proceed_to_register;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @create_your_new_account.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get create_your_new_account;

  /// No description provided for @already_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_account;

  /// No description provided for @login_here.
  ///
  /// In en, this message translates to:
  /// **'Login here...'**
  String get login_here;

  /// No description provided for @no_register_yet.
  ///
  /// In en, this message translates to:
  /// **'Not registered yet?'**
  String get no_register_yet;

  /// No description provided for @register_here.
  ///
  /// In en, this message translates to:
  /// **'Register here...'**
  String get register_here;

  /// No description provided for @welcome_user.
  ///
  /// In en, this message translates to:
  /// **'Welcome {user}!'**
  String welcome_user(Object user);

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @booking_history.
  ///
  /// In en, this message translates to:
  /// **'Booking History'**
  String get booking_history;

  /// No description provided for @create_booking.
  ///
  /// In en, this message translates to:
  /// **'Create Booking'**
  String get create_booking;

  /// No description provided for @massage_type.
  ///
  /// In en, this message translates to:
  /// **'Massage type'**
  String get massage_type;

  /// No description provided for @date_time.
  ///
  /// In en, this message translates to:
  /// **'Date and Time'**
  String get date_time;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
