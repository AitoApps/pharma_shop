import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset("images/cabas-papier-pharmacie.jpg"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
