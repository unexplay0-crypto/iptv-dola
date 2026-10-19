import 'package:flutter/material.dart';

import '../constants.dart';

/// Tema do aplicativo: Material 3, fundo escuro (padrao de apps de video),
/// acento unico, tipografia adaptativa celular vs TV.
class AppTheme {
  AppTheme._();

  static const Color _primary = Color(0xFFE50914); // vermelho de destaque
  static const Color _surface = Color(0xFF0E0E10);
  static const Color _surfaceVariant = Color(0xFF1A1A1E);
  static const Color _onSurface = Color(0xFFF5F5F5);
  static const Color _focusGlow = Color(0xFFFFFFFF);

  static ThemeData dark({required bool isTv}) {
    final base = ThemeData.dark(useMaterial3: true);
    final scale = isTv ? 1.15 : 1.0;
    return base.copyWith(
      scaffoldBackgroundColor: _surface,
      colorScheme: const ColorScheme.dark(
        primary: _primary,
        onPrimary: Colors.white,
        surface: _surface,
        surfaceVariant: _surfaceVariant,
        onSurface: _onSurface,
        onSurfaceVariant: Color(0xFFB8B8BD),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: _onSurface,
      ),
      textTheme: base.textTheme.apply(
        fontSizeFactor: scale,
        bodyColor: _onSurface,
        displayColor: _onSurface,
      ),
      focusColor: _focusGlow,
      highlightColor: _primary.withOpacity(0.25),
      splashFactory: InkSparkle.splashFactory,
    );
  }

  /// Estilo de foco para Android TV: borda brilhante + escala.
  static BoxDecoration focusDecoration(bool focused) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: focused ? Colors.white : Colors.transparent,
        width: focused ? 3 : 0,
      ),
      boxShadow: focused
          ? [
              BoxShadow(
                color: _primary.withOpacity(0.55),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ]
          : null,
    );
  }

  static const double tvBody = AppConstants.tvBodyFont;
  static const double tvTitle = AppConstants.tvTitleFont;
}
