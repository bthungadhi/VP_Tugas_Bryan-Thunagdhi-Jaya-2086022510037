import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../data/sample_cards.dart';
import 'collection_search_bar.dart';
import 'tag_filter_row.dart';
import 'vault_stats_card.dart';

class VaultSidebar extends StatelessWidget {
  final bool isDark;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final String? selectedTag;
  final ValueChanged<String?> onTagSelected;
  final int totalVisible;
  final int ownedCount;

  const VaultSidebar({
    super.key,
    required this.isDark,
    required this.searchController,
    required this.onSearchChanged,
    required this.selectedTag,
    required this.onTagSelected,
    required this.totalVisible,
    required this.ownedCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return SizedBox(
      width: 310,
      child: Container(
        margin: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF18181F) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? const Color(0xFF272732) : const Color(0xFFE4E4E7),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.tune, color: primaryColor, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'VAULT CONTROLS',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: isDark ? Colors.white : const Color(0xFF18181F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                CollectionSearchBar(
                  controller: searchController,
                  onChanged: onSearchChanged,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TagFilterRow(
                  tags: cardTags,
                  selected: selectedTag,
                  onSelected: onTagSelected,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Divider(height: 1),
                ),
                VaultStatsCard(
                  total: totalVisible,
                  ownedCount: ownedCount,
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
