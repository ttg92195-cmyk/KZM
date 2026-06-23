import 'package:google_generative_ai/google_generative_ai.dart';

import '../config/api_config.dart';

/// Formatting styles supported by KZM.
enum FormatStyle {
  formalize('Formalize', 'Convert the following text into a formal, professional tone suitable for business communication.'),
  casual('Casual', 'Rewrite the following text in a casual, friendly, conversational tone.'),
  bulletPoints('Bullet Points', 'Convert the following text into clear bullet points, capturing all key information.'),
  summarize('Summarize', 'Summarize the following text concisely while preserving the main points.');

  const FormatStyle(this.label, this.instruction);
  final String label;
  final String instruction;
}

/// Result of a Gemini API call.
sealed class GeminiResult {}

class GeminiSuccess implements GeminiResult {
  GeminiSuccess(this.text);
  final String text;
}

class GeminiError implements GeminiResult {
  GeminiError(this.message);
  final String message;
}

/// Service wrapper around the google_generative_ai package.
class GeminiService {
  GeminiService._();

  /// Calls Gemini with the given [style] applied to [input].
  ///
  /// [apiKey] overrides the default key from [ApiConfig] when provided.
  static Future<GeminiResult> formatText({
    required FormatStyle style,
    required String input,
    String? apiKey,
  }) async {
    final key = (apiKey != null && apiKey.isNotEmpty)
        ? apiKey
        : ApiConfig.geminiApiKey;

    if (key.isEmpty || key == 'YOUR_GEMINI_API_KEY_HERE') {
      return GeminiError(
        'No API key configured. Open Settings and add your Gemini API key.',
      );
    }

    try {
      final model = GenerativeModel(
        model: ApiConfig.geminiModel,
        apiKey: key,
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topP: 0.95,
          topK: 40,
        ),
      );

      final prompt = StringBuffer()
        ..writeln(style.instruction)
        ..writeln()
        ..writeln('Text to format:')
        ..writeln('"""')
        ..writeln(input.trim())
        ..writeln('"""')
        ..writeln()
        ..writeln('Return only the formatted text, no preamble.');

      final content = [Content.text(prompt.toString())];
      final response = await model.generateContent(content);

      final out = response.text?.trim();
      if (out == null || out.isEmpty) {
        return GeminiError('Empty response from Gemini.');
      }
      return GeminiSuccess(out);
    } on GenerativeAIException catch (e) {
      return GeminiError('Gemini API error: ${e.message}');
    } on FormatException catch (e) {
      return GeminiError('Response format error: ${e.message}');
    } catch (e) {
      return GeminiError('Unexpected error: $e');
    }
  }
}
