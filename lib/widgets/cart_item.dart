import 'package:provider/provider.dart';
import '../providers/cart.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String imageUrl;
  final String title;
  final double price;
  final quantity;

  CartItem(
      {required this.id,
      required this.productId,
      required this.imageUrl,
      required this.price,
      required this.quantity,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: Icon(
          Icons.delete_sweep_outlined,
          size: 50,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              content: Text('Do you want to remove $title!'),
              title: Text(
                'Are You Sure?',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                )
              ],
            );
          },
        );
      },
      child: Card(
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
          child: ListTile(
            leading: CircleAvatar(
                maxRadius: 30,
                child: FittedBox(child: Text('₹${price.roundToDouble()}'))),
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text('Total:${price * quantity}'),
            trailing: Text(
              '$quantity x',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
