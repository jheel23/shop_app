import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/product-detail-page';
  // final String title;
  // ProductDetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    /*There's a small problem here as we know it is a listener of the provider we set in main function 
    so because of that whenever something changes in product_overview_page the build function of 
    productdetail_page will also get triggred which is simply not needed because we want this to run 
    only once, so to stop that there is a feature we can use as shoen BELOW:  */
    final loadedProduct = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);
    //To make it look more clean we moved the Find by ID part in products_provider file and Applied the logic there.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.of(context).popAndPushNamed('/'),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Shop',
          style:
              TextStyle(fontSize: MediaQuery.of(context).size.height * 0.035),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(loadedProduct.imageUrl),
            ),
            Divider(
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
            Text(
              "₹${loadedProduct.price}",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              loadedProduct.description,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
