import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as htp;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Product> _item = [
    Product(
      id: 'p1',
      title: 'Red T-Shirt',
      description: 'A red T-shirt - it is pretty red!',
      price: 599.909,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5Eh8zzVSlXN88nS9N9w7ySlfueWKHbSFmkw&usqp=CAU',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 799.90,
      imageUrl:
          'https://atlas-content-cdn.pixelsquid.com/stock-images/men-s-trousers-white-pants-Xl4zYDB-600.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 299.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 199.78,
      imageUrl:
          'https://image.shutterstock.com/image-photo/fresh-vegetables-fly-pan-on-260nw-2021408180.jpg',
    ),
  ]; //Not Final because it'll change overtime as per the user Input

  List<Product> get item {
    // if (_isFavoriteOnly) {
    //   return _item.where((prodItem) => prodItem.isFavorite).toList();
    // } else {
    return [..._item]; //A copy of _item because we made it a private
    //}
  }

  List<Product> get favoriteItem {
    return _item
        .where((prodItem) => prodItem.isFavorite /*By default ture */)
        .toList();
  }

  // void showFavoriteOnly() {
  //   _isFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _isFavoriteOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _item.firstWhere((prod) => prod.id == id);
  }

  /*We Use a copy of our Items because if we don't do that then we could change the
  item from anywhere in the app , which will cause the malfuctioning of the notifyListeners() feature...
  By Passing the copy of items we are ensuring that the items can only be changed through here and can be called by notifyListeners()
  ,Which in the end will notify all the Listeners of this provider class to flollow the change. */
  Future<void> addProduct(Product product) {
    final url = Uri.parse(
        'https://shop-app-a3dc8-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
    return htp
        .post(url,
            body: json.encode(
              {
                'title': product.title,
                'price': product.price,
                'imageUrl': product.imageUrl,
                'isFavorite': product.isFavorite,
                'description': product.description,
              },
            ))
        .then(
      (response) {
        final newProduct = Product(
            //special ID created by backend, here it's Firebase
            id: json.decode(response.body)['name'],
            imageUrl: product.imageUrl,
            description: product.description,
            price: product.price,
            title: product.title);
        _item.add(newProduct);
        //_item.insert(0, newProduct); -->To add in start of list
        notifyListeners();
      },
    );
  }

  void updateProduct(String id, Product updatedProduct) {
    final prodId = _item.indexWhere((product) => product.id == id);
    if (prodId >= 0) {
      //just a safety check
      _item[prodId] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteproduct(String id) {
    _item.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
