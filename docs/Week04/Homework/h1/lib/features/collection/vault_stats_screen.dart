import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import 'data/sample_cards.dart';
import 'models/photocard.dart';

class VaultStatsScreen extends StatelessWidget {
  final List<Photocard> cards;
  final bool isDarkMode;

  const VaultStatsScreen({
    super.key,
    required this.cards,
    this.isDarkMode = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final total = cards.length;
    final ownedCount = cards.where((c) => c.owned).length;
    final wishlistCount = total - ownedCount;
    final progress = total > 0 ? (ownedCount / total) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vault Analytics'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Collection Overview', style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('Breakdown of your photocard vault status & completion.', style: theme.textTheme.bodySmall),
            const SizedBox(height: AppSpacing.md),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Vault Completion Rate', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${(progress * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold, color: primary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(value: progress, minHeight: 10, color: primary),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatBox('Total', '$total', Icons.collections_rounded, primary),
                        _buildStatBox('Owned', '$ownedCount', Icons.check_circle_rounded, primary),
                        _buildStatBox('Wishlist', '$wishlistCount', Icons.bookmark_border_rounded, Colors.orangeAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Category Breakdown', style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            for (final tag in cardTags) _buildCategoryTile(context, tag, primary),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _buildCategoryTile(BuildContext context, String tag, Color primary) {
    final catCards = cards.where((c) => c.tag == tag).toList();
    final catTotal = catCards.length;
    final catOwned = catCards.where((c) => c.owned).length;
    final catProgress = catTotal > 0 ? (catOwned / catTotal) : 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primary.withOpacity(0.15),
          child: Icon(Icons.local_offer_rounded, color: primary, size: 18),
        ),
        title: Text(tag, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: catProgress, minHeight: 4, color: primary),
            ),
            const SizedBox(height: 4),
            Text('$catOwned of $catTotal owned (${(catProgress * 100).toInt()}%)', style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
