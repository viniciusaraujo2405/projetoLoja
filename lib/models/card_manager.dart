import 'package:flutter/material.dart';

class CardManager with ChangeNotifier {
  List<Map<String, String>> _cartoes = [];

  List<Map<String, String>> get cartoes {
    return [..._cartoes]; // Retorna uma cópia da lista
  }

  void adicionarCartao(Map<String, String> cartao) {
    _cartoes.add(cartao);
    notifyListeners(); // Notifica os ouvintes da mudança
  }
}