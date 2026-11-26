// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get fillBothFields => 'Please fill in both fields.';

  @override
  String get notImplementedYet => 'Not implemented yet.';

  @override
  String get notImplementedYetDescription => 'This feature is currently in development and will be soon implemented.';

  @override
  String get staffRatio => 'Staff Ratio';

  @override
  String get currentTime => 'Current Time';

  @override
  String goodMorning(String name) {
    return 'Good Morning, $name';
  }

  @override
  String goodAfternoon(String name) {
    return 'Good Afternoon, $name';
  }

  @override
  String get searchHeadline => 'Search for patients, schedules, or messages';

  @override
  String roomWithNumber(Object roomNumber) {
    return 'Room $roomNumber';
  }

  @override
  String get high => 'High';

  @override
  String get middle => 'Middle';

  @override
  String get low => 'Low';

  @override
  String get urgentAlerts => 'Urgent Alerts';

  @override
  String get shiftPlan => 'Shift Plan';

  @override
  String get notifications => 'Notifications';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get authException => 'Authentication Exception';

  @override
  String get joinAsOrganization => 'Request Access as an Organization';

  @override
  String get loginInstead => 'Login instead';

  @override
  String get name => 'Name';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get logMeds => 'Log Meds';

  @override
  String get recordVitals => 'Record Vitals';

  @override
  String get patientTransfer => 'Patient Transfer';

  @override
  String get reportIncident => 'Report Incident';

  @override
  String get contactPhysician => 'Contact Physician';

  @override
  String get customize => 'Customize';

  @override
  String get codeBlue => 'Code Blue';

  @override
  String get codeBlueDescription => 'A Code Blue has been triggered. Please respond immediately.';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get patient => 'Patient';

  @override
  String get patients => 'Patients';

  @override
  String get schedule => 'Schedule';

  @override
  String get messaging => 'Messaging';

  @override
  String get collapse => 'Collapse';

  @override
  String get expand => 'Expand';

  @override
  String get priorityPatients => 'Priority Patients';

  @override
  String get room => 'Room';

  @override
  String get status => 'Status';

  @override
  String get spo2 => 'SpO2';

  @override
  String get pulse => 'Pulse';

  @override
  String get temperature => 'Temperature';

  @override
  String get temp => 'Temp';

  @override
  String get lastSync => 'Last Sync';

  @override
  String get viewAll => 'View All';

  @override
  String get noNewNotifications => 'No new notifications';
}
