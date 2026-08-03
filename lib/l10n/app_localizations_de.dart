// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get username => 'Nutzername';

  @override
  String get password => 'Passwort';

  @override
  String get login => 'Einloggen';

  @override
  String get fillBothFields => 'Bitte füllen Sie beide Felder aus.';

  @override
  String get notImplementedYet => 'Noch nicht implementiert.';

  @override
  String get notImplementedYetDescription => 'Diese Funktion ist aktuell noch in der Entwicklung und wird bald implementiert.';

  @override
  String get staffRatio => 'Personalquote';

  @override
  String get currentTime => 'Aktuelle Zeit';

  @override
  String goodMorning(String name) {
    return 'Guten Morgen, $name';
  }

  @override
  String goodAfternoon(String name) {
    return 'Guten Tag, $name';
  }

  @override
  String get searchHeadline => 'Suche nach Patienten, Terminen oder Nachrichten';

  @override
  String room(String roomNumber) {
    return 'Zimmer $roomNumber';
  }

  @override
  String get high => 'Hoch';

  @override
  String get middle => 'Mittel';

  @override
  String get low => 'Niedrig';

  @override
  String get urgentAlerts => 'Wichtige Warnungen';

  @override
  String get shiftPlan => 'Dienstplan';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get helpCenter => 'Hilfe Center';

  @override
  String get settings => 'Einstellungen';

  @override
  String get logout => 'Logout';

  @override
  String get authException => 'Authentifizierungs Fehler';
}
