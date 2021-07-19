class Constants {
  static _PageURL pageUrl = const _PageURL();
  static _PreferenceField preferenceField = const _PreferenceField();

  static const double padding = 20;
  static const double avatarRadius = 45;
}

class _PageURL {
  const _PageURL();

  final splash = '/splash';
  final login = '/login';
  final todo = '/todo';
}

class _PreferenceField {
  const _PreferenceField();

  final isLoggedIn = "IS_LOGGED_IN";
  final accessToken = "ACCESS_TOKEN";
  final todos = "TODOS";
}

enum LoginState {
  NotLoggedIn,
  LoggingIn,
  Syncing,
  SyncComplete,
}
