import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final ValueNotifier<bool> isDesktopNotifier = ValueNotifier<bool>(false);

bool get isDesktop => isDesktopNotifier.value;

void setIsDesktop(bool value) {
  if (isDesktopNotifier.value == value) return;
  isDesktopNotifier.value = value;
}