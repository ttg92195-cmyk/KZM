import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/text_formatter_provider.dart';

/// Output panel with copy button and scrollable text.
class OutputPanel extends ConsumerWidget {
  const OutputPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final output = ref.watch(outputTextProvider);
    final error = ref.watch(errorMessageProvider);
    final theme = Theme.of(context);

    final hasError = error.isNotEmpty;
    final hasOutput = output.isNotEmpty;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      hasError ? Icons.error_outline : Icons.output,
                      size: 18,
                      color: hasError
                          ? theme.colorScheme.error
                          : theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      hasError ? 'Error' : 'Formatted Output',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                if (hasOutput && !hasError)
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    tooltip: 'Copy to clipboard',
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: output));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied to clipboard'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Expanded(
              child: hasError
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        error,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    )
                  : hasOutput
                      ? SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: SelectableText(
                            output,
                            style: theme.textTheme.bodyLarge,
                          ),
                        )
                      : Center(
                          child: Text(
                            'Your formatted text will appear here.',
                            style: theme.textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
