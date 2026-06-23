import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/text_formatter_provider.dart';
import '../services/settings_service.dart';

/// Dialog for editing the Gemini API key.
class SettingsDialog extends ConsumerStatefulWidget {
  const SettingsDialog({super.key});

  @override
  ConsumerState<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends ConsumerState<SettingsDialog> {
  late final TextEditingController _controller;
  bool _obscure = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final current = ref.read(apiKeyProvider).maybeWhen(
          data: (k) => k,
          orElse: () => '',
        );
    _controller = TextEditingController(text: current);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await SettingsService.setApiKey(_controller.text.trim());
    ref.invalidate(apiKeyProvider);
    setState(() => _saving = false);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _clear() async {
    setState(() => _saving = true);
    await SettingsService.clearApiKey();
    _controller.clear();
    ref.invalidate(apiKeyProvider);
    setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.settings, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          const Text('Settings'),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gemini API Key',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Get your key from aistudio.google.com/apikey',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              obscureText: _obscure,
              decoration: InputDecoration(
                hintText: 'Paste your API key',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _saving ? null : _clear,
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Clear key'),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}
