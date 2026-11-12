import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/deck.dart';
import '../providers/settings_provider.dart';
import '../widgets/flip_card.dart';

class StudyScreen extends StatefulWidget {
  final Deck deck;

  const StudyScreen({super.key, required this.deck});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  int _index = 0;
  int _knownInSession = 0;

  bool get _finished => _index >= widget.deck.words.length;

  void _answer(bool known) {
    final word = widget.deck.words[_index];
    setState(() {
      word.isLearned = known;
      if (known) _knownInSession++;
      _index++;
    });
  }

  void _restart() {
    setState(() {
      _index = 0;
      _knownInSession = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsProvider>();
    final total = widget.deck.words.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.t('study_title', {'name': widget.deck.name})),
      ),
      body: SafeArea(
        child: _finished ? _buildResult(s, total) : _buildStudy(s, total),
      ),
    );
  }

  Widget _buildStudy(SettingsProvider s, int total) {
    final word = widget.deck.words[_index];
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(s.t('card_of', {'a': '${_index + 1}', 'b': '$total'})),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _index / total,
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
          ),
          const Spacer(),
          FlipCard(
            key: ValueKey(word.id),
            front: _face(
              color: scheme.primaryContainer,
              children: [
                Text(
                  word.term,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(s.t('tap_flip')),
              ],
            ),
            back: _face(
              color: scheme.secondaryContainer,
              children: [
                Text(
                  word.meaning,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  word.example,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _answer(false),
                  icon: const Icon(Icons.close),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(s.t('not_known')),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _answer(true),
                  icon: const Icon(Icons.check),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(s.t('known')),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _face({required Color color, required List<Widget> children}) {
    return Card(
      color: color,
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildResult(SettingsProvider s, int total) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎉', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            Text(
              s.t('deck_done'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              s.t('known_session', {'a': '$_knownInSession', 'b': '$total'}),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _restart,
              icon: const Icon(Icons.replay),
              label: Text(s.t('restart')),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(s.t('back_decks')),
            ),
          ],
        ),
      ),
    );
  }
}
