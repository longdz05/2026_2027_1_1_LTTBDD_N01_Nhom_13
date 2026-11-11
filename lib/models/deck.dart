import 'word.dart';

class Deck {
  final String id;
  final String name;
  final String icon; // emoji cho đơn giản
  final List<Word> words;

  Deck({
    required this.id,
    required this.name,
    required this.icon,
    required this.words,
  });

  int get learnedCount => words.where((w) => w.isLearned).length;

  double get progress => words.isEmpty ? 0 : learnedCount / words.length;
}
