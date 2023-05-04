import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String id;
  final double price;
  final int quantity;
  final String imageUrl;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.id,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};
  //getter COPY of _item -->
  Map<String, CartItem> get item {
    return {..._item};
  }

  int get itemCount {
    return _item.length;
  }

  int get totalprice {
    double total = 0.0;
    _item.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total.round();
  }

  void removeSingleItem(String productId) {
    if (!_item.containsKey(productId)) {
      return;
    }
    if (_item[productId]!.quantity > 1) {
      _item.update(
          productId,
          (exixtingCartItem) => CartItem(
              title: exixtingCartItem.title,
              id: exixtingCartItem.id,
              price: exixtingCartItem.price,
              imageUrl: exixtingCartItem.imageUrl,
              quantity: exixtingCartItem.quantity - 1));
    } else {
      _item.remove(productId);
    }
    notifyListeners();
  }

  void addItem(String title, double price, String productId, String imageUrl) {
    if (_item.containsKey(productId)) {
      _item.update(
          productId,
          (exixtingCartItem) => CartItem(
              title: exixtingCartItem.title,
              id: exixtingCartItem.id,
              price: exixtingCartItem.price,
              imageUrl: exixtingCartItem.imageUrl,
              quantity: exixtingCartItem.quantity + 1));
    } else {
      _item.putIfAbsent(
          productId,
          () => CartItem(
              imageUrl: imageUrl,
              title: title,
              id: DateTime.now().toString(),
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _item = {};
    notifyListeners();
  }
}
