import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          // "All" chip
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: ChoiceChip(
              avatar: Icon(
                Icons.grid_view_rounded,
                size: 14,
                color: selected == null
                    ? Colors.white
                    : (isDark ? Colors.white60 : Colors.black54),
              ),
              label: const Text('All Vaults'),
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: selected == null ? FontWeight.bold : FontWeight.normal,
                color: selected == null
                    ? Colors.white
                    : (isDark ? Colors.white70 : Colors.black87),
              ),
              selected: selected == null,
              selectedColor: primaryColor,
              backgroundColor: isDark ? const Color(0xFF1E1E24) : Colors.white,
              elevation: selected == null ? 3 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: selected == null
                      ? primaryColor
                      : (isDark ? Colors.white12 : Colors.black12),
                ),
              ),
              onSelected: (_) => onSelected(null),
            ),
          ),
          for (final tag in tags)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: ChoiceChip(
                avatar: Icon(
                  _getTagIcon(tag),
                  size: 14,
                  color: tag == selected
                      ? Colors.white
                      : (isDark ? Colors.white60 : Colors.black54),
                ),
                label: Text(
                  tag,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: tag == selected ? FontWeight.bold : FontWeight.normal,
                  color: tag == selected
                      ? Colors.white
                      : (isDark ? Colors.white70 : Colors.black87),
                ),
                selected: tag == selected,
                selectedColor: primaryColor,
                backgroundColor: isDark ? const Color(0xFF1E1E24) : Colors.white,
                elevation: tag == selected ? 3 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: tag == selected
                        ? primaryColor
                        : (isDark ? Colors.white12 : Colors.black12),
                  ),
                ),
                onSelected: (on) => onSelected(on ? tag : null),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getTagIcon(String tag) {
    switch (tag.toLowerCase()) {
      case 'album':
        return Icons.album_rounded;
      case 'lucky draw':
        return Icons.casino_rounded;
      case 'fansign':
        return Icons.draw_rounded;
      default:
        return Icons.local_offer_rounded;
    }
  }
}
