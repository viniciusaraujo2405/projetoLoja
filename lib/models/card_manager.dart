import 'package:flutter/material.dart';

class CardManager with ChangeNotifier {
  List<Map<String, String>> _cartoes = [];

  List<Map<String, String>> get cartoes {
    return [..._cartoes]; 
  }

  void addCard(Map<String, String> card) {
    _cartoes.add(card);
    notifyListeners();
  }
}
