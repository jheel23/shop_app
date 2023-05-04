import 'package:flutter/material.dart';

import '../providers/orders.dart';

import 'package:provider/provider.dart';
import '../providers/cart.dart';

import '../widgets/cart_item.dart' as ci;

class CartPage extends StatelessWidget {
  static const routeName = '/cart-page';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(children: [
        Card(
          elevation: 10,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                  ),
                  Spacer(),
                  Consumer<Cart>(
                    builder: (ctx, cartItem, _) => Chip(
                        label: Text(
                      '₹${cartItem.totalprice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrders(
                            cart.item.values.toList(),
                            cart.totalprice.toDouble());
                        cart.clearCart();
                      },
                      child: Text(
                        "Order Now",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ))
                ]),
          ),
        ),
        //We use Expanded here cause otherwise listView Will take all the space and here expanded forces it to take the space available
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemBuilder: (ctx, index) => ci.CartItem(
                productId: cart.item.keys.toList()[index],
                id: cart.item.values.toList()[index].id,
                imageUrl: cart.item.values.toList()[index].imageUrl,
                price: cart.item.values.toList()[index].price,
                quantity: cart.item.values.toList()[index].quantity,
                title: cart.item.values.toList()[index].title),
            itemCount: cart.itemCount,
          ),
        ),
      ]),
    );
  }
}
