/// EXAMPLE API Configuration file.
///
/// Copy this file to `api_config.dart` and replace the placeholder
/// with your actual Gemini API key from https://aistudio.google.com/apikey
///
/// ```bash
/// cp lib/config/api_config_example.dart lib/config/api_config.dart
/// ```
///
/// NOTE: `api_config.dart` is gitignored to prevent accidental commits.

class ApiConfig {
  ApiConfig._();

  /// Replace with your own Gemini API key.
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';

  /// Gemini model to use.
  static const String geminiModel = 'gemini-1.5-flash';
}
