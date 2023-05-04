import 'package:flutter/material.dart';
import 'package:shop_app/pages/edit_product_page.dart';

import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/maindrawer.dart';
import 'package:shop_app/widgets/user_product_items.dart';
import 'package:provider/provider.dart';

class UserProductPage extends StatelessWidget {
  static const routeName = '/user-product-page';
  const UserProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);

    return Scaffold(
      drawer: main_drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductPage.routeName);
              },
              icon: Icon(Icons.add))
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('My Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                  productData.item[index].id,
                  productData.item[index].imageUrl,
                  productData.item[index].title),
              Divider(
                color: Colors.blueGrey,
              )
            ],
          ),
          itemCount: productData.item.length,
        ),
      ),
    );
  }
}
