import 'package:flutter/material.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({@required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  List<String> commands;

  _setCartProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('cart', commands);

    setState(() {});
  }

  Future<List<String>> _getCartProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> res = prefs.getStringList('cart');

    //res == null ? commands = List() : commands = res;

    return res == null ?  List() : res;


  }

  _clearCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear().then((success) {
      success == true ? print("clear successfuly") : print("clear failed");
    });
  }




  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    // _clearCartProducts();

    _getCartProducts().then((res){
      this.commands = res;
      print("init: $commands");

      setState(() {});

    });

  }

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
                  Image.asset(widget.product.imageUrl),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(labelText: "Enter Quatity", labelStyle: TextStyle(
                fontSize: 16.0, fontWeight: FontWeight.bold
              )),
              keyboardType: TextInputType.number,
            ),
          ),

          RaisedButton(
            color: Colors.green,
            onPressed: (){

              final commande = Commande(product: widget.product, quantity: 20);
              var jsonCommande = commande.toJson();
              String stringC = json.encode(jsonCommande);

              commands.add(stringC);

              print(commands);

              _setCartProducts();

              Navigator.of(context).pop();
            },
            child: Text("ajouter au panier", style: TextStyle(fontSize: 20.0, color: Colors.white)),
          )

        ],
      ),
    );
  }
}
