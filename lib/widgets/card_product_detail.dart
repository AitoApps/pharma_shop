import 'package:flutter/material.dart';
import 'package:pharma_shop/model/product.dart';

class CardProductDetail extends StatelessWidget {
  final Product product;

  CardProductDetail({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(product.imageUrl),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("kartona diale dowa",
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                SizedBox(height: 2.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("20 DH",
                      style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8.0,),
                    Text("3 DH",
                      style: TextStyle(
                          fontSize: 12.0, color: Colors.grey, decoration: TextDecoration.lineThrough
                      ),
                    ),
                    SizedBox(width: 8.0,),
                    Text("40% off",
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    SizedBox(height: 8.0,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
