// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

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
  String room(String roomNumber) {
    return 'Room';
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
}
