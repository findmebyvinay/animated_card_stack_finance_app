

abstract class SharedPrefData {
  Future<void> saveAuthToken({required String token});
  String get getAuthToken;
  Future<void> clearAuthToken();

  Future<void> saveTheme({required String theme});
  String? get getTheme;

  Future<void> saveLanguage({required String language});
  String? get getLanguage;

  Future<void> clearAllSharedData();
}
