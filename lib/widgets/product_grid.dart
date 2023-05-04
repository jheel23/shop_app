import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import './product_item.dart';

class ProductGrid extends StatelessWidget {
  final favscreen;
  ProductGrid(this.favscreen);
  @override
  Widget build(BuildContext context) {
    //SETTING UP LISTENER
    final productsData = Provider.of<ProductProvider>(context);
    //In above we didn,t change the listen argument because by default it it=s set to true
    //and also i do want to rebuild it if something changes in  ProductProvider()
    final itemsavailable =
        favscreen ? productsData.favoriteItem : productsData.item;
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 5 / 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        //We use this .value approach when working with list and Grid where DATA can go beyond screen
        //Also when using an existing data like here Product already exixt and we are using it
        value: itemsavailable[index],
        //create: (ctx) => itemsavailable[index],
        child: ProductItem(
            /* id: itemsavailable[index].id,
            imageUrl: itemsavailable[index].imageUrl,
            title: itemsavailable[index].title*/
            ),
      ),
      //Here we have no problem using a constructor to pass DATA because we display it in PRoductItem() instead passing it arround.
      itemCount: itemsavailable.length,
    );
  }
}
