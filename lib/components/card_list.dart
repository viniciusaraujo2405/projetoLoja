import 'package:flutter/material.dart';

class CardList with ChangeNotifier {
  final List<Map<String, String>> _cards = [];

  List<Map<String, String>> get cards => [..._cards];

  void addCard(Map<String, String> card) {
    _cards.add(card);
    notifyListeners();
  }

  bool get hasCards => _cards.isNotEmpty;
}
