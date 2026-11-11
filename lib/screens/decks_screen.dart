import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/deck.dart';
import '../widgets/deck_card.dart';
import 'deck_detail_screen.dart';

class DecksScreen extends StatefulWidget {
  const DecksScreen({super.key});

  @override
  State<DecksScreen> createState() => _DecksScreenState();
}

class _DecksScreenState extends State<DecksScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final List<Deck> filtered = sampleDecks
        .where((d) => d.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Bộ thẻ')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Tìm bộ thẻ...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('Không tìm thấy bộ thẻ nào'))
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final deck = filtered[index];
                      return DeckCard(
                        deck: deck,
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DeckDetailScreen(deck: deck),
                            ),
                          );
                          if (mounted) setState(() {});
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
