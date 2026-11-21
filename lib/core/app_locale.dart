import 'package:flutter/material.dart';

// Global notifier for the selected app locale.
/// If the notifier's value is `null`, the system/device locale is used.
/// Use `setLocale(...)` to change the app language at runtime (pass `null` to
/// reset to system locale).
final ValueNotifier<Locale?> localeNotifier = ValueNotifier<Locale?>(null);

void setLocale(Locale? locale) {
  localeNotifier.value = locale;
}
