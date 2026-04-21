import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';

class HiveService {
  final Box _authBox = Hive.box(AppConstants.authBox);
  final Box _settingsBox = Hive.box(AppConstants.settingsBox);

  // ---------- Token ----------

  String? getAccessToken() {
    return _authBox.get(AppConstants.accessTokenKey);
  }

  String? getRefreshToken() {
    return _authBox.get(AppConstants.refreshTokenKey);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _authBox.put(AppConstants.accessTokenKey, accessToken);
    await _authBox.put(AppConstants.refreshTokenKey, refreshToken);
  }

  Future<void> clearTokens() async {
    await _authBox.delete(AppConstants.accessTokenKey);
    await _authBox.delete(AppConstants.refreshTokenKey);
  }

  bool get isLoggedIn => getAccessToken() != null;

  // ---------- Settings ----------

  String getLanguage() {
    return _settingsBox.get(AppConstants.languageKey, defaultValue: 'en');
  }

  Future<void> saveLanguage(String langCode) async {
    await _settingsBox.put(AppConstants.languageKey, langCode);
  }
}
