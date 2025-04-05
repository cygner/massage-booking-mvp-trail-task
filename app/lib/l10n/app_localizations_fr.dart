// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get app_name => 'Nom de l\'application';

  @override
  String get welcome_back => 'Bon retour';

  @override
  String get login_to_your_account => 'Connectez-vous à votre compte';

  @override
  String get login => 'Se connecter';

  @override
  String get enter_register_email => 'Entrez votre adresse e-mail enregistrée';

  @override
  String get enter_password => 'Entrez votre mot de passe';

  @override
  String get proceed_to_login => 'Procéder à la connexion';

  @override
  String get enter_your_name => 'Entrez votre nom';

  @override
  String get enter_your_email => 'Entrez votre adresse e-mail';

  @override
  String get proceed_to_register => 'Procéder à l\'inscription';

  @override
  String get register => 'S\'inscrire';

  @override
  String get create_your_new_account => 'Créer un compte';

  @override
  String get already_account => 'Vous avez déjà un compte ?';

  @override
  String get login_here => 'Connectez-vous ici...';

  @override
  String get no_register_yet => 'Pas encore inscrit ?';

  @override
  String get register_here => 'Inscrivez-vous ici...';

  @override
  String welcome_user(Object user) {
    return 'Bienvenue $user !';
  }

  @override
  String get book => 'Réserver';

  @override
  String get booking_history => 'Historique des réservations';

  @override
  String get create_booking => 'Créer une réservation';

  @override
  String get massage_type => 'Type de massage';

  @override
  String get date_time => 'Date et heure';
}
