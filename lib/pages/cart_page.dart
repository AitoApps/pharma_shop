import 'package:flutter/material.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/auth.dart';

import 'dart:convert';
import 'dart:async';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<Map<String, dynamic>> jsonCommands = List();

  List<Commande> commandes = List();

  Future<List<String>> _getCartProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> res = prefs.getStringList('cart');

    //res == null ? commands = List() : commands = res;

    return res == null ? List() : res;

  }



  UserAuth userAuth = UserAuth();

  FirebaseUser user;

  @override
  void initState() {

    super.initState();

    userAuth.currentUser().then((user){
      this.user = user;
    });

    _getCartProducts().then((res){

      print("res : $res");

      res.forEach((stringC) {
          Map<String, dynamic> jsonC = json.decode(stringC);

          Commande commande = Commande.fromJson(jsonC);

          commandes.add(commande);

          setState(() {});
      });

      print("init: $commandes");

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" ${commandes.length} Products"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.send),
              onPressed: (){
                // push to firestore
                print("dfffffffff");
                Firestore.instance.runTransaction((transaction) async {
                  CollectionReference reference = Firestore.instance.collection('orders');

                  Future.forEach(commandes, (Commande order) async {

                    await reference.add({
                      "user_id": user.uid,
                      "name": order.product.name,
                      "price": order.product.currentPrice,
                      "quantity": order.quantity

                    });
                  });
                });



              }
          )
        ],
      ),
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
                                onPressed: (){},
                                icon: Icon(Icons.edit),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.shop),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.delete),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}
