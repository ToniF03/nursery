// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort';

  @override
  String get login => 'Einloggen';

  @override
  String get register => 'Registrieren';

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
  String goodEvening(String name) {
    return 'Guten Abend, $name';
  }

  @override
  String get searchHeadline => 'Suche nach Patienten, Terminen oder Nachrichten';

  @override
  String roomWithNumber(String roomNumber) {
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

  @override
  String get joinAsOrganization => 'Zugriff als Organisation anfordern';

  @override
  String get loginInstead => 'Stattdessen Anmelden';

  @override
  String get name => 'Name';

  @override
  String get quickActions => 'Schnellaktionen';

  @override
  String get logMeds => 'Medikamente protokollieren';

  @override
  String get recordVitals => 'Vitalwerte aufzeichnen';

  @override
  String get patientTransfer => 'Patientenübertragung';

  @override
  String get reportIncident => 'Vorfall melden';

  @override
  String get contactPhysician => 'Arzt kontaktieren';

  @override
  String get customize => 'Anpassen';

  @override
  String get codeBlue => 'Herzalarm';

  @override
  String get codeBlueDescription => 'Ein Herzalarm wurde ausgelöst. Bitte reagieren Sie sofort.';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get patient => 'Patient';

  @override
  String get patients => 'Patienten';

  @override
  String get schedule => 'Zeitplan';

  @override
  String get messaging => 'Nachrichten';

  @override
  String get collapse => 'Einklappen';

  @override
  String get expand => 'Ausklappen';

  @override
  String get priorityPatients => 'Dringende Patienten';

  @override
  String get room => 'Zimmer';

  @override
  String get status => 'Status';

  @override
  String get spo2 => 'SpO2';

  @override
  String get pulse => 'Puls';

  @override
  String get temperature => 'Temperatur';

  @override
  String get temp => 'Temp';

  @override
  String get lastSync => 'Letzte Sync';

  @override
  String get viewAll => 'Alle anzeigen';

  @override
  String get noNewNotifications => 'Aktuell keine neuen Benachrichtigungen';

  @override
  String get critical => 'Kritisch';

  @override
  String get warning => 'Warnung';

  @override
  String get stable => 'Stabil';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get hospitalized => 'Hospitalisiert';
}
