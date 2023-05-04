import 'package:flutter/material.dart';
import 'cart.dart';

class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItems(
      {required this.amount,
      required this.id,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItems> _orders = [];

  List<OrderItems> get orders {
    return [..._orders];
  }

  void addOrders(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItems(
            dateTime: DateTime.now(),
            amount: total,
            id: DateTime.now().toString(),
            products:
                cartProducts)); //We used INSERT here instead of ADD because
    //"insert" adds from start whereas "add" from end.
    //thats why to show recent orders on top we used insert
    notifyListeners();
  }
}
