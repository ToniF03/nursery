import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Shared desktop layout state used across the app shell and dashboard.
final ValueNotifier<bool> isDesktopNotifier = ValueNotifier<bool>(false);

bool get isDesktop => isDesktopNotifier.value;

// Updates the layout state only when the desktop/mobile mode changes.
void setIsDesktop(bool value) {
  if (isDesktopNotifier.value == value) return;
  isDesktopNotifier.value = value;
}
