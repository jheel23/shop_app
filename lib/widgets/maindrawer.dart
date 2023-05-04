import 'package:flutter/material.dart';
import 'package:shop_app/pages/user_product_page.dart';
import '../pages/orders_page.dart';

class main_drawer extends StatelessWidget {
  const main_drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Hello Friend! 😒',
              style: TextStyle(fontSize: 30, fontFamily: 'anton'),
            ),
            automaticallyImplyLeading: false,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Orders',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersPage.routeName);
            },
          ),
          Divider(
            thickness: 1.5,
            color: Colors.blueGrey,
          ),
          ListTile(
            leading: Icon(
              Icons.shop,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Shop',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(
            thickness: 1.5,
            color: Colors.blueGrey,
          ),
          ListTile(
            leading: Icon(
              Icons.edit,
              color: Colors.white,
              size: 30,
            ),
            title: FittedBox(
              child: Text(
                'Manage Products',
                maxLines: 1,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductPage.routeName);
            },
          ),
          Divider(
            thickness: 1.5,
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
