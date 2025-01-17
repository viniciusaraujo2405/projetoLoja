import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/badgee.dart';
import '../components/app_drawer.dart';
import '../components/product_grid.dart';
import '../models/cart.dart';
import '../models/product_list.dart';
import '../utils/app_routes.dart';

enum FilterOptions{
  Favorite,
  All,
}	
class ProductsOverviewPage extends StatelessWidget{
  ProductsOverviewPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final provider = Provider.of<ProductList>(context);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_)=>[
              PopupMenuItem(
                
                value: FilterOptions.Favorite,
                child: Text('Somente Favoritos'),
              ),
              PopupMenuItem(
                
                value: FilterOptions.All,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions selectedValue){
              if(selectedValue == FilterOptions.Favorite){
                provider.showFavoriteOnly();
              }else{
                provider.showAll();
              }
            },
          ),
          Consumer<Cart>(
            child : IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                },
                icon: Icon(Icons.shopping_cart),
            ), 
            builder: (ctx,cart,child) => Badgee (
              value: cart.itemsCount.toString(),
              child: child!,
              ),
            ),
          
        ],

      ),
      body: ProductGrid(),
      drawer: AppDrawer(),
      );
    
  }


}

