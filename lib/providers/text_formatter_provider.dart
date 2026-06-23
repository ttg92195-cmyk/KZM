import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/gemini_service.dart';
import '../services/settings_service.dart';

/// Async snapshot of the locally stored API key.
final apiKeyProvider = FutureProvider<String>((ref) async {
  return SettingsService.getApiKey();
});

/// State of the text input field.
final inputTextProvider = StateProvider<String>((ref) => '');

/// Currently selected format style.
final selectedStyleProvider = StateProvider<FormatStyle>(
  (ref) => FormatStyle.formalize,
);

/// Whether a request is in-flight.
final isProcessingProvider = StateProvider<bool>((ref) => false);

/// Last formatted output (success case).
final outputTextProvider = StateProvider<String>((ref) => '');

/// Last error message (empty when none).
final errorMessageProvider = StateProvider<String>((ref) => '');

/// Whether settings sheet is open.
final isSettingsOpenProvider = StateProvider<bool>((ref) => false);

/// Triggers Gemini formatting using the current input + selected style.
final formatTextProvider = FutureProvider.autoDispose<void>((ref) async {
  final input = ref.read(inputTextProvider).trim();
  if (input.isEmpty) {
    ref.read(errorMessageProvider.notifier).state =
        'Please enter some text first.';
    return;
  }

  final style = ref.read(selectedStyleProvider);
  final key = await ref.read(apiKeyProvider.future);

  ref.read(isProcessingProvider.notifier).state = true;
  ref.read(errorMessageProvider.notifier).state = '';

  final result = await GeminiService.formatText(
    style: style,
    input: input,
    apiKey: key,
  );

  ref.read(isProcessingProvider.notifier).state = false;

  switch (result) {
    case GeminiSuccess(:final text):
      ref.read(outputTextProvider.notifier).state = text;
    case GeminiError(:final message):
      ref.read(errorMessageProvider.notifier).state = message;
  }
});
