import 'package:flutter/material.dart';

class SpecialCartIcon extends StatelessWidget {
  final Widget child;
  final String itemsInCart;

  SpecialCartIcon({
    required this.child,
    required this.itemsInCart,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 7,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(1.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.red),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              itemsInCart,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
