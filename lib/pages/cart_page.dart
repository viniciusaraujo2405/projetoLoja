import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/card_manager.dart';

import '../components/cart_item_widget.dart';
import '../models/cart.dart';
import '../models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    final cartoes = Provider.of<CardManager>(context).cartoes; 

    void _showSelectedPayment(BuildContext context, String paymentMethod) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Método de pagamento selecionado: $paymentMethod"),
        ),
      );
    }

    void _showCardSelectionDialog(BuildContext context, List<Map<String, String>> cartoes) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Selecione o Cartão"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: cartoes.map((cartao) {
                return ListTile(
                  title: Text(cartao['nome'] ?? ''),
                  subtitle: Text(
                    '**** **** **** ${cartao['numero']?.substring(cartao['numero']!.length - 4)}',
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showSelectedPayment(context, "Cartão: ${cartao['nome']}");
                  },
                );
              }).toList(),
            ),
          );
        },
      );
    }

    void _askCredit(BuildContext context) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Selecione o número de parcelas"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text("1x"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showSelectedPayment(context, "Crédito 1x");
                  },
                ),
                // Adicione mais opções de parcelamento
              ],
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
            title: Text("Selecione o Método de Pagamento"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text("Crédito"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _askCredit(context);
                  },
                ),
                ListTile(
                  title: Text("Débito"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showSelectedPayment(context, "Débito");
                  },
                ),
                ListTile(
                  title: Text("Pix"),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _showSelectedPayment(context, "Pix");
                  },
                ),
                // Opção para escolher cartão cadastrado
                if (cartoes.isNotEmpty)
                  ListTile(
                    title: Text("Cartão Cadastrado"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _showCardSelectionDialog(context, cartoes);
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
        title: Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 30,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      _showPaymentMethodDialog(context);
                    },
                    child: Text('PAGAMENTO'),
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
                    child: Text('COMPRAR'),
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
