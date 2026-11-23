class Globals {
  static final Globals _instance = Globals._internal();

  factory Globals() => _instance;

  Globals._internal();

  Map<String, dynamic>? currentUser;
  String? userName;
  String? fullName;
}
