import 'package:shared_preferences/shared_preferences.dart';

/// Local storage for user settings (API key, format history, etc.)
class SettingsService {
  SettingsService._();

  static const _kApiKey = 'gemini_api_key';

  /// Returns the API key from storage, or empty string if not set.
  static Future<String> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kApiKey) ?? '';
  }

  /// Saves the API key to storage.
  static Future<void> setApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kApiKey, key);
  }

  /// Clears the stored API key.
  static Future<void> clearApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kApiKey);
  }
}
