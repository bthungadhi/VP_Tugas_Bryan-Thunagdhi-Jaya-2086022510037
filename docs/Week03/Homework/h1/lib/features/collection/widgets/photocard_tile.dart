import 'package:flutter/material.dart';
import 'package:h1/core/theme/app_spacing.dart';
import 'package:h1/features/collection/models/photocard.dart';

class PhotocardTile extends StatelessWidget {
  const PhotocardTile({
    super.key,
    required this.card,
    required this.onToggleOwned,
  });

  final Photocard card;
  final VoidCallback onToggleOwned;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              card.imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => ColoredBox(
                color: scheme.surfaceContainerHighest,
                child: Center(
                  child: Icon(
                    Icons.broken_image,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.member,
                        style: text.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        card.album,
                        style: text.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: card.owned ? 'Mark as missing' : 'Mark as owned',
                  onPressed: onToggleOwned,
                  icon: Icon(
                    card.owned ? Icons.favorite : Icons.favorite_border,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}