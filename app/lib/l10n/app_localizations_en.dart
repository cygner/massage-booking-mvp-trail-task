// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'App Name';

  @override
  String get welcome_back => 'Welcome Back';

  @override
  String get login_to_your_account => 'Login to your account';

  @override
  String get login => 'Login';

  @override
  String get enter_register_email => 'Enter your registered email';

  @override
  String get enter_password => 'Enter your password';

  @override
  String get proceed_to_login => 'Proceed to Login';

  @override
  String get enter_your_name => 'Enter your name';

  @override
  String get enter_your_email => 'Enter your email';

  @override
  String get proceed_to_register => 'Proceed to Register';

  @override
  String get register => 'Register';

  @override
  String get create_your_new_account => 'Create an account';

  @override
  String get already_account => 'Already have an account?';

  @override
  String get login_here => 'Login here...';

  @override
  String get no_register_yet => 'Not registered yet?';

  @override
  String get register_here => 'Register here...';

  @override
  String welcome_user(Object user) {
    return 'Welcome $user!';
  }

  @override
  String get book => 'Book';

  @override
  String get booking_history => 'Booking History';

  @override
  String get create_booking => 'Create Booking';

  @override
  String get massage_type => 'Massage type';

  @override
  String get date_time => 'Date and Time';
}
