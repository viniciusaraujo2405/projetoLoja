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
                          _askCreditInstallments(context);
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
 
