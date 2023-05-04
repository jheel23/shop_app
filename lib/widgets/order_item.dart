import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItems extends StatefulWidget {
  final ord.OrderItems order;
  OrderItems(this.order);

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text("${widget.order.amount}"),
              subtitle: Text(
                DateFormat('dd/MM/yyy \n hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  icon: Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    size: 30,
                  )),
            ),
            if (_expanded)
              Container(
                  height: min(widget.order.products.length * 20.0 + 10, 100),
                  child: ListView(
                    children: widget.order.products
                        .map(
                          (prod) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  prod.title,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  '${prod.price}',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ))
          ],
        ));
  }
}
