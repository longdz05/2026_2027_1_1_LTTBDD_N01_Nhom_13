class Word {
  final String id;
  final String term;
  final String meaning;
  final String example;
  bool isLearned;

  Word({
    required this.id,
    required this.term,
    required this.meaning,
    required this.example,
    this.isLearned = false,
  });
}
