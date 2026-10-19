import 'package:flutter/material.dart';

class VaultContentHeader extends StatelessWidget {
  final int total;
  final bool isDark;
  final bool hasFilter;
  final VoidCallback onResetFilter;

  const VaultContentHeader({
    super.key,
    required this.total,
    required this.isDark,
    required this.hasFilter,
    required this.onResetFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Collection Vault',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: isDark ? Colors.white : const Color(0xFF18181F),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Showing $total photocards in gallery',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? const Color(0xFFA1A1AA) : const Color(0xFF71717A),
                ),
              ),
            ],
          ),
          if (hasFilter)
            ActionChip(
              avatar: const Icon(Icons.clear_rounded, size: 14),
              label: const Text(
                'Clear',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              onPressed: onResetFilter,
            ),
        ],
      ),
    );
  }
}
