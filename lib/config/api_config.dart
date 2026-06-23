/// API Configuration.
///
/// The recommended way to provide the API key is at runtime via the in-app
/// Settings screen — the runtime key is stored on-device with
/// `shared_preferences` and overrides any bundled value.
///
/// Alternatively, you can build the APK with a default key via:
///   flutter build apk --release --dart-define=GEMINI_API_KEY=YOUR_KEY
///
/// Or replace the empty string below with your key from
/// https://aistudio.google.com/apikey (NOT recommended for public repos).

class ApiConfig {
  ApiConfig._();

  /// Default Gemini API key.
  ///
  /// Priority order (highest first):
  ///   1. Runtime key entered via in-app Settings
  ///   2. --dart-define=GEMINI_API_KEY=... passed at build time
  ///   3. This empty fallback (the app will prompt the user to enter a key)
  static const String geminiApiKey =
      String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');

  /// Gemini model to use.
  static const String geminiModel = 'gemini-1.5-flash';
}
