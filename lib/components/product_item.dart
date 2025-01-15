
import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/pages/product_detail_page.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem ({
    Key? key,
    required this.product
    }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  GridTile(
        child: GestureDetector(
          child:Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            ),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ProductDetailPage(product: product),
                ),
              );
            },
          ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite),
          color: Theme.of(context).colorScheme.secondary,
          ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
          ),
        trailing: IconButton(
          onPressed: (){},
          icon: Icon(Icons.shopping_cart),
          color: Theme.of(context).colorScheme.secondary,
            ),
      ),
    );

    
  }

}