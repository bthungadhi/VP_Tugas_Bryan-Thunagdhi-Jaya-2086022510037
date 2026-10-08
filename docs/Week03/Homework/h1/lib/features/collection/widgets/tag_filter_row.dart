import 'package:flutter/material.dart';
import 'package:h1/core/theme/app_spacing.dart';

class TagFilterRow extends StatelessWidget {
  const TagFilterRow({
    super.key,
    required this.tags,
    required this.selected,
    required this.onSelected,
  });

  final List<String> tags;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          for (final tag in tags)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: FilterChip(
                label: Text(tag),
                selected: tag == selected,
                onSelected: (on) => onSelected(on ? tag : null),
              ),
            ),
        ],
      ),
    );
  }
}