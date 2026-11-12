import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/deck.dart';
import '../providers/settings_provider.dart';
import 'quiz_screen.dart';
import 'study_screen.dart';

class DeckDetailScreen extends StatefulWidget {
  final Deck deck;

  const DeckDetailScreen({super.key, required this.deck});

  @override
  State<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends State<DeckDetailScreen> {
  Future<void> _openStudy() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => StudyScreen(deck: widget.deck)));
    if (mounted) setState(() {});
  }

  Future<void> _openQuiz() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => QuizScreen(deck: widget.deck)));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsProvider>();
    final deck = widget.deck;

    return Scaffold(
      appBar: AppBar(title: Text('${deck.icon} ${deck.name}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.t('learned_count', {
                    'a': '${deck.learnedCount}',
                    'b': '${deck.words.length}',
                  }),
                ),
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
                      onPressed: _openStudy,
                      icon: const Icon(Icons.style),
                      label: Text(s.t('study_btn')),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _openQuiz,
                      icon: const Icon(Icons.quiz),
                      label: Text(s.t('quiz_btn')),
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
}
