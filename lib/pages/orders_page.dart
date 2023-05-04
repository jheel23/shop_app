import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/maindrawer.dart';
import '../widgets/order_item.dart' as ord;
import '../providers/orders.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = 'orders-page';
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        drawer: main_drawer(),
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Your Orders',
            )),
        body: ListView.builder(
          itemBuilder: (ctx, index) => ord.OrderItems(orderData.orders[index]),
          itemCount: orderData.orders.length,
        ));
  }
}
