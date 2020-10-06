import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import '../screens/cart_screen.dart';

enum DisplayOptions {
  ShowFavorites,
  ShowAll,
}

class ProductOverviewScreen extends StatelessWidget {
  final _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: [
            Consumer<Cart>(
              builder: (ctx, cart, cartConsumerChild) => Badge(
                // since IconButton no need to rebuild (only value needs to rebuild),
                // we can put IconButton in child of Consumer which is then pass via 3rd arguments
                // `cartConsumerChild`. This widget here will NOT be rebuilt!
                child: cartConsumerChild,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
            PopupMenuButton(
              onSelected: (DisplayOptions selectedValue) {
                print('selectedValue..... $selectedValue');

                // setState(() {
                //   if (selectedValue == DisplayOptions.ShowFavorites) {
                //     _showFavoriteOnly = true;
                //   } else {
                //     _showFavoriteOnly = false;
                //   }
                // });
              },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  child: Text('Show Favorites'),
                  value: DisplayOptions.ShowFavorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: DisplayOptions.ShowAll,
                )
              ],
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Products>(context, listen: false).fetchProducts(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (dataSnapshot.error != null) {
              return Center(child: Text('An error occurred!'));
            } else {
              return ProductsGrid(_showFavoriteOnly);
            }
          },
        ));
  }
}
