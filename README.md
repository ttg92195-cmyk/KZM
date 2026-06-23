# KZM — AI Text Formatter

A minimalist Flutter app that uses **Google Gemini** to reformat text into four styles — **Formalize**, **Casual**, **Bullet Points**, and **Summarize**.

<p align="center">
  <img src="assets/images/app_logo.png" width="120" height="120" alt="KZM Logo">
</p>

## Features

- Multi-line text input
- 4 formatting presets powered by Gemini 1.5 Flash
- Scrollable formatted output panel
- One-tap copy to clipboard
- Material 3 dark theme (pure black + red accent)
- Built-in API key manager (key stored on-device via SharedPreferences)
- Adaptive Android launcher icon

## Tech Stack

| Layer            | Choice                                  |
| ---------------- | --------------------------------------- |
| UI Framework     | Flutter (Material 3)                    |
| State Management | Riverpod (`flutter_riverpod`)           |
| AI Backend       | `google_generative_ai` (Gemini 1.5)     |
| Storage          | `shared_preferences`                    |
| Build            | Flutter → Android Release APK           |
| CI               | GitHub Actions (auto-builds APK on push)|

## Getting Started (Local Development)

### 1. Prerequisites

- Flutter SDK ≥ 3.5 (Dart ≥ 3.5)
- Android Studio / Xcode (for emulators)
- A Gemini API key from <https://aistudio.google.com/apikey>

### 2. Clone & install

```bash
git clone https://github.com/ttg92195-cmyk/KZM.git
cd KZM
flutter pub get
```

### 3. Configure the API key

```bash
cp lib/config/api_config_example.dart lib/config/api_config.dart
```

Edit `lib/config/api_config.dart` and paste your Gemini API key:

```dart
static const String geminiApiKey = 'YOUR_KEY_HERE';
```

> `lib/config/api_config.dart` is **gitignored** — your key will not be
> pushed to GitHub.

Alternatively, you can leave the file empty and enter the key at runtime
via the ⚙️ Settings dialog inside the app. The runtime key is stored on
the device with `shared_preferences` and overrides the bundled one.

### 4. Run

```bash
flutter run
```

### 5. Build a release APK locally

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

## CI / GitHub Actions

Every push to `main` (or PR) triggers the workflow at
`.github/workflows/build-apk.yml`, which:

1. Checks out the code
2. Sets up JDK 17 + Flutter stable
3. Runs `flutter pub get`
4. Builds `flutter build apk --release`
5. Uploads the APK as an artifact (30-day retention)
6. Creates a GitHub Release tagged `v1.0.<run_number>` with the APK attached

Download the APK from the **Actions** tab → choose the latest run →
scroll to **Artifacts** → `kzm-release-apk`.

## Project Structure

```
lib/
├── main.dart                         # App entry + MaterialApp
├── config/
│   ├── api_config.dart               # gitignored - real API key
│   └── api_config_example.dart       # template to copy
├── theme/
│   └── app_theme.dart                # Material 3 dark theme
├── services/
│   ├── gemini_service.dart           # Gemini API wrapper
│   └── settings_service.dart         # SharedPreferences wrapper
├── providers/
│   └── text_formatter_provider.dart  # Riverpod providers
├── widgets/
│   ├── format_style_selector.dart    # Horizontal chip row
│   ├── output_panel.dart             # Output + Copy button
│   └── settings_dialog.dart          # API key editor
└── screens/
    └── home_screen.dart              # Main screen
```

## Security Notes

- The bundled API key in `lib/config/api_config.dart` is **not** committed
  (gitignored). Use the in-app Settings screen to enter the key on-device.
- Rotate your key regularly from <https://aistudio.google.com/apikey>.
- The APK produced by CI is **debug-signed** by default. For Play Store
  distribution, provision a keystore, add a `key.properties` file under
  `android/`, and the build will automatically pick it up.

## Roadmap

- [ ] History / saved-formats list
- [ ] Share intent (receive text from other apps)
- [ ] iOS support
- [ ] Light theme toggle

## License

MIT — see `LICENSE`.
