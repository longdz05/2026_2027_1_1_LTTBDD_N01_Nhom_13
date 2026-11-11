import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/deck.dart';
import '../models/word.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  final Deck deck;

  const QuizScreen({super.key, required this.deck});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const int _secondsPerQuestion = 10;

  final Random _random = Random();
  late List<Word> _questions;
  late List<String> _options;
  int _index = 0;
  int _score = 0;
  int _timeLeft = _secondsPerQuestion;
  String? _selected;
  final List<Word> _wrongWords = [];
  Timer? _timer;

  Word get _current => _questions[_index];

  @override
  void initState() {
    super.initState();
    _startQuiz();
  }

  void _startQuiz() {
    _questions = List<Word>.from(widget.deck.words)..shuffle(_random);
    _index = 0;
    _score = 0;
    _wrongWords.clear();
    _prepareQuestion();
  }

  void _prepareQuestion() {
    final wrong =
        widget.deck.words
            .where((w) => w.id != _current.id)
            .map((w) => w.meaning)
            .toList()
          ..shuffle(_random);
    _options = [_current.meaning, ...wrong.take(3)]..shuffle(_random);
    _selected = null;
    _timeLeft = _secondsPerQuestion;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_timeLeft <= 1) {
        t.cancel();
        _answer(null); // hết giờ tính là sai
      } else {
        setState(() => _timeLeft--);
      }
    });
  }

  void _answer(String? choice) {
    if (_selected != null) return;
    _timer?.cancel();
    final correct = choice == _current.meaning;
    setState(() {
      _selected = choice ?? '';
      if (correct) {
        _score++;
      } else {
        _wrongWords.add(_current);
      }
    });
    Future.delayed(const Duration(milliseconds: 900), _next);
  }

  void _next() {
    if (!mounted) return;
    if (_index + 1 >= _questions.length) {
      _showResult();
    } else {
      setState(() {
        _index++;
        _prepareQuestion();
      });
    }
  }

  void _showResult() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => QuizResultScreen(
          score: _score,
          total: _questions.length,
          wrongWords: List<Word>.from(_wrongWords),
          onRetry: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => QuizScreen(deck: widget.deck)),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Color? _optionColor(String option) {
    if (_selected == null) return null;
    if (option == _current.meaning) return Colors.green.shade300;
    if (option == _selected) return Colors.red.shade300;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final total = _questions.length;

    return Scaffold(
      appBar: AppBar(title: Text('Kiểm tra: ${widget.deck.name}')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Câu ${_index + 1} / $total'),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 18),
                      const SizedBox(width: 4),
                      Text('$_timeLeft s'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: _timeLeft / _secondsPerQuestion,
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 32),
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      const Text('Nghĩa của từ này là gì?'),
                      const SizedBox(height: 8),
                      Text(
                        _current.term,
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ..._options.map(
                (option) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      backgroundColor: _optionColor(option),
                    ),
                    onPressed: _selected == null ? () => _answer(option) : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(option, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
