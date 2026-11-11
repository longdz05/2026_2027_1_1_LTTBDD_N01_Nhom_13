import 'package:flutter/material.dart';

import 'data/sample_data.dart';
import 'utils/theme.dart';
import 'widgets/flip_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordFlip',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final word = sampleDecks[0].words[0];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FlipCard(
          front: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: SizedBox(
              width: 300,
              height: 200,
              child: Center(
                child: Text(word.term, style: const TextStyle(fontSize: 32)),
              ),
            ),
          ),
          back: Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: SizedBox(
              width: 300,
              height: 200,
              child: Center(
                child: Text(word.meaning, style: const TextStyle(fontSize: 28)),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Text('$_counter'),
      ),
    );
  }
}
