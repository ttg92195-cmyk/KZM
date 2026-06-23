import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/text_formatter_provider.dart';
import '../services/gemini_service.dart';

/// Horizontal chip row for picking a [FormatStyle].
class FormatStyleSelector extends ConsumerWidget {
  const FormatStyleSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedStyleProvider);
    final isProcessing = ref.watch(isProcessingProvider);

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: FormatStyle.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final style = FormatStyle.values[index];
          final isSelected = style == selected;
          return ChoiceChip(
            label: Text(style.label),
            selected: isSelected,
            onSelected: isProcessing
                ? null
                : (_) => ref.read(selectedStyleProvider.notifier).state = style,
            selectedColor: Theme.of(context).colorScheme.primary,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            side: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          );
        },
      ),
    );
  }
}
