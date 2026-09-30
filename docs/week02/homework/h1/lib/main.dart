import 'package:flutter/material.dart';
import 'package:h1/core/theme/app_theme.dart';
import 'package:h1/features/collection/collection_screen.dart';

void main() => runApp(const VaultApp());

class VaultApp extends StatelessWidget {
  const VaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photocard Vault',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const CollectionScreen(),
    );
  }
}