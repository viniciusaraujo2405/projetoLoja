import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item_widget.dart';
import 'package:shop/models/order_list.dart';

import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final Cart cart = Provider.of(context);
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
                  ListTile(
                    title: Text("2x"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _showSelectedPayment(context, "Crédito 2x");
                    },
                  ),
                  ListTile(
                    title: Text("3x"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _showSelectedPayment(context, "Crédito 3x");
                    },
                  ),
                  ListTile(
                    title: Text("4x"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _showSelectedPayment(context, "Crédito 4x");
                    },
                  ),
                  ListTile(
                    title: Text("5x"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _showSelectedPayment(context, "Crédito 5x");
                    },
                  ),
                  ListTile(
                    title: Text("6x"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _showSelectedPayment(context, "Crédito 6x");
                    },
                  ),
                  ListTile(
                    title: Text("7x"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _showSelectedPayment(context, "Crédito 7x");
                    },
                  ),
                  ListTile(
                    title: Text("8x"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _showSelectedPayment(context, "Crédito 8x");
                    },
                  ),
                  ListTile(
                    title: Text("9x"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _showSelectedPayment(context, "Crédito 9x");
                    },
                  ),
                  ListTile(
                    title: Text("10x"),
                    onTap: () {
                      Navigator.of(ctx).pop();
                      _showSelectedPayment(context, "Crédito 10x");
                    },
                  ),
                ],
              ),
            );
          }
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
              horizontal: 15,
              vertical: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10,),
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
                    onPressed: (){
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
                    onPressed: (){
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
              itemBuilder: (ctx, i) => CartItemWidget (items[i]),
                
              
            ),
          )




        ],
      ),
    );
  }
}
 
