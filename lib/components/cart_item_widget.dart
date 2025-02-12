import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget (
    this.cartItem, {
    Key? key,
    }) : super(key: key);

  @override 
  Widget build(BuildContext context){
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.redAccent,
       
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
         child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      onDismissed: (_) {
        Provider.of<Cart>(context,
         listen:false,
        ).removeItem(cartItem.productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: FittedBox(
                  child: Text('\$${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.name),
            subtitle: Text('Total: \$${cartItem.price * cartItem.quantity}'),
            trailing: Text('${cartItem.quantity} x'),
          ),
        ),
      ),
    );
  }

}