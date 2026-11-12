import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/word.dart';
import '../providers/settings_provider.dart';

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final List<Word> wrongWords;
  final VoidCallback onRetry;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.wrongWords,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsProvider>();
    final percent = total == 0 ? 0 : (score / total * 100).round();
    final emoji = percent >= 80 ? '🏆' : (percent >= 50 ? '👍' : '💪');

    return Scaffold(
      appBar: AppBar(
        title: Text(s.t('result_title')),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 64)),
              const SizedBox(height: 8),
              Text(
                s.t('correct_count', {'a': '$score', 'b': '$total'}),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text('$percent%'),
              const SizedBox(height: 16),
              if (wrongWords.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    s.t('review_words'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              Expanded(
                child: wrongWords.isEmpty
                    ? Center(child: Text(s.t('all_correct')))
                    : ListView.separated(
                        itemCount: wrongWords.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, i) => ListTile(
                          leading: const Icon(Icons.close, color: Colors.red),
                          title: Text(wrongWords[i].term),
                          subtitle: Text(wrongWords[i].meaning),
                        ),
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(s.t('exit')),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: onRetry,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(s.t('retry')),
                      ),
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
