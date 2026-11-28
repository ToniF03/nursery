import 'package:flutter/foundation.dart';

class Globals {
  static final Globals _instance = Globals._internal();

  factory Globals() => _instance;

  Globals._internal();

  final ValueNotifier<String?> userNameListenable = ValueNotifier(null);
  String? _userName;

  Map<String, dynamic>? currentUser;
  String? fullName;

  String? get userName => _userName;

  set userName(String? value) {
    if (_userName == value) return;
    _userName = value;
    userNameListenable.value = value;
  }
}
