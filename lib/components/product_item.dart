
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/cart.dart';

class ProductItem extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return  GridTile(
        child: GestureDetector(
          child:Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            ),
            onTap: (){
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_DETAIL,
                arguments: product,
                );
            },
          ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            product.toggleFavorite();
          },
          icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
          color: Theme.of(context).colorScheme.secondary,
          ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
          ),
        trailing: IconButton(
          onPressed: (){
            cart.addItem(product);
            

          },
          icon: Icon(Icons.shopping_cart),
          color: Theme.of(context).colorScheme.secondary,
            ),
      ),
    );

    
  }

}