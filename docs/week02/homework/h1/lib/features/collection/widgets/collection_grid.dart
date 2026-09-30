import 'package:flutter/material.dart';
import 'package:h1/core/theme/app_spacing.dart';
import 'package:h1/features/collection/models/photocard.dart';
import 'package:h1/features/collection/widgets/photocard_tile.dart';

class CollectionGrid extends StatelessWidget {
  const CollectionGrid({
    super.key,
    required this.items,
    required this.onToggleOwned,
  });

  final List<Photocard> items;
  final ValueChanged<String> onToggleOwned;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.72,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final card = items[index];
        return PhotocardTile(
          key: ValueKey(card.id),
          card: card,
          onToggleOwned: () => onToggleOwned(card.id),
        );
      },
    );
  }
}