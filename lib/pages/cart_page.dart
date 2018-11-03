import 'package:flutter/material.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/widgets/drawer_menu.dart';

import 'dart:convert';
import 'dart:async';


class CartPage extends StatefulWidget {

  FirebaseUser user;

  CartPage({@required this.user});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<Map<String, dynamic>> jsonCommands = List();

  List<Commande> commandes = List();

  int total_price;

  Future<List<String>> _getCartProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> res = prefs.getStringList('cart');

    return res == null ? List() : res;

  }

  _clearCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear().then((success) {
      success == true ? print("clear successfuly") : print("clear failed");

      setState(() {
        commandes = List();
      });
    });
  }

  @override
  void initState() {

    super.initState();

    this.total_price = 0;

    _getCartProducts().then((res){

      print("res : $res");

      res.forEach((stringC) {
          Map<String, dynamic> jsonC = json.decode(stringC);

          Commande commande = Commande.fromJson(jsonC);

          commandes.add(commande);

          total_price += commande.product.currentPrice * commande.quantity;

          setState(() {});
      });

      print("init: $commandes");

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" ${commandes.length} Orders : $total_price Dh"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.done, size: 40.0, color: Colors.yellow,),
              onPressed: (){
                // push to firestore
                 send_order();
              }
          )
        ],
      ),
      drawer: DrawerMenu(user: widget.user,),
      body: ListView.builder(

          itemCount: commandes.length,
          itemBuilder: (context, index) {
            final commande = commandes[index];
            return Card(
              elevation: 4.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  Container(
                      width: 200.0,
                      child: Image.asset('${commande.product.imageUrl}')
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          //color: Colors.green,
                          child: Center(
                            child: Text('${commande.product.name}', style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0
                            ),),
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        Row(
                          children: <Widget>[
                            Text('price       :', style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(width: 20.0,),
                            Text('${commande.product.currentPrice} dh')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('quantity : ', style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            SizedBox(width: 20.0,),
                            Text('${commande.quantity} ')
                          ],
                        ),
                       SizedBox(height: 20.0,),
                        Row(
                          children: <Widget>[
                            Text('facture   :', style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            SizedBox(width: 20.0,),
                            Text('${commande.product.currentPrice * commande.quantity} dh')
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Container(height: 0.5, color: Colors.grey,),
                        SizedBox(height: 5.0,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    commande.quantity += 1;
                                    total_price = 0;
                                    commandes.forEach((commande){
                                      total_price += commande.product.currentPrice * commande.quantity;
                                    });
                                  });

                                },
                                icon: Icon(Icons.plus_one),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    commande.quantity -= 1;
                                    total_price = 0;
                                    commandes.forEach((commande){
                                      total_price += commande.product.currentPrice * commande.quantity;
                                    });
                                  });
                                },
                                icon: Icon(Icons.exposure_neg_1),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    commandes.remove(commande);
                                    total_price = 0;
                                    commandes.forEach((commande){
                                      total_price += commande.product.currentPrice * commande.quantity;
                                    });
                                  });
                                },
                                icon: Icon(Icons.delete),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

  Future send_order() async {
             // push to firestore
    print("test1");
    Firestore.instance.runTransaction((transaction) async {
      CollectionReference reference = Firestore.instance.collection('orders');

      Future.forEach(this.commandes, (Commande order) async {
        print("test2");
        await reference.add({
          "user_id": widget.user.uid,
          "user_name": widget.user.displayName,
          "name": order.product.name,
          "price": order.product.currentPrice,
          "image_url": order.product.imageUrl,
          "quantity": order.quantity,
          "status": "pending"

        });
      }).then((_){
        print("test3");
        _clearCartProducts();
       Navigator.of(context).pop();
        print("test4");
      });
    });
  }
}
