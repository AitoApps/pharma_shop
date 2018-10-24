import 'package:flutter/material.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


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

  @override
  void initState() {
    
    super.initState();

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
        title: Text("Cart Products"),
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
                        SizedBox(height: 40.0,),
                        Row(
                          children: <Widget>[
                            Text('price : ', style: TextStyle(
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
                            Text('${commande.quantity} dh')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('facture : ', style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            SizedBox(width: 20.0,),
                            Text('${commande.product.currentPrice * commande.quantity} dh')
                          ],
                        ),
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
