import 'package:flutter/material.dart';

import '../models/word.dart';

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
    final percent = total == 0 ? 0 : (score / total * 100).round();
    final emoji = percent >= 80 ? '🏆' : (percent >= 50 ? '👍' : '💪');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả'),
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
                '$score / $total câu đúng',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text('$percent%'),
              const SizedBox(height: 16),
              if (wrongWords.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Từ cần ôn lại',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              Expanded(
                child: wrongWords.isEmpty
                    ? const Center(
                        child: Text('Bạn trả lời đúng hết, tuyệt vời!'),
                      )
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
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('Thoát'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: onRetry,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('Làm lại'),
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
