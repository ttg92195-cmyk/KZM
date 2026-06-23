import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/text_formatter_provider.dart';
import '../widgets/format_style_selector.dart';
import '../widgets/output_panel.dart';
import '../widgets/settings_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = ref.watch(inputTextProvider);
    final isProcessing = ref.watch(isProcessingProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Z',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text('KZM'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => const SettingsDialog(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Clear all',
            onPressed: () {
              ref.read(inputTextProvider.notifier).state = '';
              ref.read(outputTextProvider.notifier).state = '';
              ref.read(errorMessageProvider.notifier).state = '';
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Input area
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.edit_note,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text('Your Text', style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    minLines: 4,
                    maxLines: 8,
                    value: input,
                    onChanged: (v) =>
                        ref.read(inputTextProvider.notifier).state = v,
                    style: theme.textTheme.bodyLarge,
                    decoration: const InputDecoration(
                      hintText: 'Type or paste the text you want to format...',
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Format style selector
            const FormatStyleSelector(),

            const SizedBox(height: 12),

            // Format button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FilledButton.icon(
                onPressed: isProcessing
                    ? null
                    : () => ref.invalidate(formatTextProvider),
                icon: isProcessing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.auto_fix_high),
                label: Text(isProcessing ? 'Formatting...' : 'Format Text'),
              ),
            ),

            const SizedBox(height: 16),

            // Output area
            const Expanded(child: OutputPanel()),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
