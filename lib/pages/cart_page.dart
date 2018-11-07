import 'package:flutter/material.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/widgets/drawer_menu.dart';
import 'package:pharma_shop/model/cart.dart';
import 'package:scoped_model/scoped_model.dart';

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
        title:
            ScopedModelDescendant<CartModel>(builder: (context, child, model)=> Text(
                " ${model.cartProducts.length.toString()} Orders : ${model.totalPrice.toString()} Dh"
            )),
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
     // drawer: DrawerMenu(user: widget.user,),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) =>
          ListView.builder(
              itemCount: model.cartProducts.length,
              itemBuilder: (context, index) {
                final commande = model.cartProducts[index];
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
                                  child:
                                  ScopedModelDescendant<CartModel>(builder: (context, child, model) =>
                                  IconButton(
                                    onPressed: (){
                                       model.incrementQuantity(commande);
                                    },
                                    icon: Icon(Icons.plus_one),
                                  )),
                                ),
                                Expanded(
                                  child: ScopedModelDescendant<CartModel>(builder: (context, child, model) =>
                                      IconButton(
                                        onPressed: (){
                                          model.decrementQuantity(commande);
                                        },
                                        icon: Icon(Icons.exposure_neg_1),
                                      )),
                                ),
                                Expanded(
                                  child: ScopedModelDescendant<CartModel>(builder: (context, child, model){
                                    return IconButton(
                                      onPressed: (){
                                        model.removeFromCart(commande);
                                      },
                                      icon: Icon(Icons.delete),
                                    );
                                  })
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
          )
    );
  }

  Future send_order() async {
             // push to firestore
    print("test1");

    final orders = CartModel.of(context).cartProducts;

    print(orders);

    Firestore.instance.runTransaction((transaction) async {
      CollectionReference reference = Firestore.instance.collection('orders');

      Future.forEach(CartModel.of(context).cartProducts, (Commande order) async {
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
        CartModel.of(context).clearCart();
        Navigator.of(context).pop();
        print("test4");
      });
    });
  }
}
