import 'package:flutter/material.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/auth.dart';
import 'package:pharma_shop/widgets/card_product_detail.dart';

import 'dart:convert';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({@required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  List<String> commands;
  FirebaseUser user;
  _setCartProducts(int quantity) async {

    final commande = Commande(product: widget.product, quantity: quantity, clientId: user.uid);
    var jsonCommande = commande.toJson();
    String stringC = json.encode(jsonCommande);

    commands.add(stringC);

   // print(commands);

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('cart', commands);

    setState(() {});
  }

  Future<List<String>> _getCartProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> res = prefs.getStringList('cart');

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

    UserAuth userAuth = UserAuth();

    userAuth.currentUser().then((user){
      this.user = user;
    });

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
            child: CardProductDetail(product: widget.product)
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

              _setCartProducts(20);

              Navigator.of(context).pop();
            },
            child: Text("ajouter au panier", style: TextStyle(fontSize: 20.0, color: Colors.white)),
          )

        ],
      ),
    );
  }
}
