import 'package:flutter/material.dart';

import '../models/deck.dart';

class DeckCard extends StatelessWidget {
  final Deck deck;
  final VoidCallback onTap;

  const DeckCard({super.key, required this.deck, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(deck.icon, style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 8),
              Text(deck.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text('${deck.words.length} từ'),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: deck.progress,
                minHeight: 6,
                borderRadius: BorderRadius.circular(8),
                backgroundColor: scheme.surfaceContainerHighest,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
