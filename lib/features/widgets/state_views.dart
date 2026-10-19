import 'package:flutter/material.dart';

/// Estados de tela: carregamento, vazio, erro, fonte nao configurada.
class StateViews {
  StateViews._();

  static Widget loading({String message = 'Carregando...'}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  static Widget empty({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? action,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: Colors.white38),
            const SizedBox(height: 16),
            Text(title,
                style: const TextStyle(fontSize: 20, color: Colors.white70),
                textAlign: TextAlign.center),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(subtitle,
                  style: const TextStyle(fontSize: 15, color: Colors.white54),
                  textAlign: TextAlign.center),
            ],
            if (action != null) ...[const SizedBox(height: 24), action],
          ],
        ),
      ),
    );
  }

  static Widget error({
    required String message,
    VoidCallback? onRetry,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.white38),
            const SizedBox(height: 16),
            Text(message,
                style: const TextStyle(fontSize: 18, color: Colors.white70),
                textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static Widget noSource({required VoidCallback onAddPlaylist}) {
    return empty(
      icon: Icons.playlist_add,
      title: 'Nenhuma playlist configurada',
      subtitle:
          'Adicione uma lista M3U/M3U Plus em Configuracoes para comecar a assistir.',
      action: FilledButton.icon(
        onPressed: onAddPlaylist,
        icon: const Icon(Icons.add),
        label: const Text('Adicionar playlist'),
      ),
    );
  }
}
