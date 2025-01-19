import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/models/order_list.dart';

import '../models/cart.dart';
import '../models/card_manager.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    final CardManager cardManager = Provider.of<CardManager>(context); // Gerencia os cartões
    final items = cart.items.values.toList();

    void _showSelectedPayment(BuildContext context, String paymentMethod) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Método de pagamento selecionado: $paymentMethod"),
        ),
      );
    }

    void _askCredit(BuildContext context) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Selecione o número de parcelas"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                10,
                (index) => ListTile(
                  title: Text("${index + 1}x"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showSelectedPayment(context, "Crédito ${index + 1}x");
                  },
                ),
              ),
            ),
          );
        },
      );
    }

    void _showCardSelectionDialog(BuildContext context) {
      if (cardManager.cards.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nenhum cartão cadastrado!")),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Selecione o Cartão"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: cardManager.cards.map((card) {
                return ListTile(
                  title: Text(card['nome']!),
                  subtitle: Text("**** **** **** ${card['numero']!.substring(card['numero']!.length - 4)}"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _askCredit(context);
                  },
                );
              }).toList(),
            ),
          );
        },
      );
    }

    void _showPaymentMethodDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Selecione o Método de Pagamento"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text("Cartão de Crédito"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showCardSelectionDialog(context);
                  },
                ),
                ListTile(
                  title: const Text("Débito"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showSelectedPayment(context, "Débito");
                  },
                ),
                ListTile(
                  title: const Text("Pix"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showSelectedPayment(context, "Pix");
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 30,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      _showPaymentMethodDialog(context);
                    },
                    child: const Text('PAGAMENTO'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<OrderList>(context, listen: false).addOrder(cart);
                      cart.clear();
                    },
                    child: const Text('COMPRAR'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) => CartItemWidget(items[i]),
            ),
          ),
        ],
      ),
    );
  }
}
