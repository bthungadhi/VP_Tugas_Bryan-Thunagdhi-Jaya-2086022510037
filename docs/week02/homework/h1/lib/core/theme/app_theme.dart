import 'package:flutter/material.dart';

/// Satu-satunya tempat warna dan tema didefinisikan.
/// Kode fitur hanya boleh memakai Theme.of(context).
class AppTheme {
  static const _seed = Color(0xFF7C4DFF);

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seed,
        brightness: brightness,
      ),
    );
  }
}