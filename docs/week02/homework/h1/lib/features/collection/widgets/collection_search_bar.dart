import 'package:flutter/material.dart';
import 'package:h1/core/theme/app_spacing.dart';

class CollectionSearchBar extends StatelessWidget {
  const CollectionSearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: SearchBar(
        hintText: 'Search member',
        leading: const Icon(Icons.search),
        onChanged: onChanged,
      ),
    );
  }
}