class ApiConfig {
  const ApiConfig._();

  /// Root Laravel
  static const String serverUrl = 'http://127.0.0.1:8000';

  /// Endpoint API
  static const String baseUrl = '$serverUrl/api/v1';

  /// Folder Storage Laravel
  static const String storageUrl = '$serverUrl/storage';

  /// Google OAuth
  static const String googleClientId =
      '170232690367-0a18spgd9sr6lc8o6usdeipplqc1u252.apps.googleusercontent.com';

  static const String googleServerClientId =
      '170232690367-0a18spgd9sr6lc8o6usdeipplqc1u252.apps.googleusercontent.com';
}