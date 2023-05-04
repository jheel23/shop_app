import 'package:flutter/material.dart';
import 'package:shop_app/pages/cart_screen.dart';
import '../widgets/maindrawer.dart';
import 'package:shop_app/widgets/SpecialCartIcon.dart';

import '../widgets/product_grid.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewPage extends StatefulWidget {
  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  var _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: main_drawer(),
      appBar: AppBar(
        title: Text(
          'Shop',
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.035),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Favorites',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text(
                  'Show All',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                value: FilterOptions.All,
              )
            ],
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions.Favorites) {
                  _showFavoriteOnly = true;
                  // productsContainer.showFavoriteOnly();
                } else {
                  _showFavoriteOnly = false;
                  // productsContainer.showAll();
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => SpecialCartIcon(
              //These are named arguments not widgets
              child: ch as Widget,
              itemsInCart: cart.itemCount.toString(),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartPage.routeName);
                },
                icon: Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.orange,
                )),
          )
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
