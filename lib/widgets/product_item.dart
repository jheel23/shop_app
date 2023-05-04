import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/product_detail_page.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem({required this.id, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cartProduct = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        child: GestureDetector(
          //We used GestureDetector on image only here coz if we used it on
          //Whole gridTile/ClipRRect then it would affect the functioning of our IconButtons
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailPage.routeName, arguments: product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        //footer: It is used to add something at the bottom of the grid
        footer: GridTileBar(
          leading: /*Just Another Optimization */ Consumer<Product>(
            builder: (ctx, productx,
                    child /*This "child" argument is about thing that doesnt change inside consumer*/) =>
                IconButton(
                    onPressed: () {
                      productx.toggleFavorite();
                    },
                    icon: Icon(
                      productx.isFavorite
                          ? (Icons.favorite)
                          : (Icons.favorite_border),
                      color: Colors.red,
                      size: 29,
                    )),
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              onPressed: () {
                cartProduct.addItem(
                    product.title, product.price, product.id, product.imageUrl);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cartProduct.removeSingleItem(product.id);
                      }),
                  backgroundColor: Colors.black38,
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  content: const Text('Added to Cart!',
                      style: TextStyle(
                        fontFamily: 'lato',
                        color: Colors.orange,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center),
                  duration: Duration(milliseconds: 900),
                ));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.orange,
              )),
        ),
      ),
    );
  }
}
