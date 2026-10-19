import 'package:flutter/material.dart';

class VaultHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final VoidCallback? onToggleTheme;
  final VoidCallback? onOpenStats;
  final ValueChanged<dynamic> onSelectDataset;

  const VaultHeader({
    super.key,
    required this.isDarkMode,
    this.onToggleTheme,
    this.onOpenStats,
    required this.onSelectDataset,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF16161D) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDarkMode ? const Color(0xFF272732) : const Color(0xFFE4E4E7),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor,
                      primaryColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.style_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PHOTOCARD VAULT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: isDarkMode ? Colors.white : const Color(0xFF18181F),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Digital K-Pop Collectibles Gallery',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDarkMode ? const Color(0xFF71717A) : const Color(0xFFA1A1AA),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.analytics_rounded, color: primaryColor, size: 20),
                tooltip: 'Vault Analytics',
                onPressed: onOpenStats,
              ),
              IconButton(
                icon: Icon(
                  isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                  color: primaryColor,
                  size: 20,
                ),
                tooltip: 'Toggle Theme Mode',
                onPressed: onToggleTheme,
              ),
              PopupMenuButton<dynamic>(
                icon: Icon(Icons.tune_rounded, color: primaryColor, size: 20),
                tooltip: 'Select Test Dataset',
                onSelected: onSelectDataset,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: isDarkMode ? const Color(0xFF18181F) : Colors.white,
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(Icons.collections_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Normal List (6 Cards)'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.format_list_bulleted_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Long List (500 Cards)'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(Icons.inbox_rounded, size: 18),
                        SizedBox(width: 8),
                        Text('Empty State (0 Cards)'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
