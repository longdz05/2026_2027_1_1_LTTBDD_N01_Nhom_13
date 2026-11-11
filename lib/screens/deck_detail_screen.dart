import 'package:flutter/material.dart';

import '../models/deck.dart';

class DeckDetailScreen extends StatelessWidget {
  final Deck deck;

  const DeckDetailScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${deck.icon} ${deck.name}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Đã thuộc ${deck.learnedCount} / ${deck.words.length} từ'),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: deck.progress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: deck.words.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final word = deck.words[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(word.term),
                  subtitle: Text(word.meaning),
                  trailing: Icon(
                    word.isLearned
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: word.isLearned ? Colors.green : null,
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => _soon(context),
                      icon: const Icon(Icons.style),
                      label: const Text('Học'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _soon(context),
                      icon: const Icon(Icons.quiz),
                      label: const Text('Kiểm tra'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Tính năng này sẽ có sau!')));
  }
}
