import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pharma_shop/model/cart.dart';
import 'package:pharma_shop/pages/product_detail_page.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsListItem extends StatefulWidget {

  final Product product;
  final FirebaseUser user;

  ProductsListItem({@required this.product, @required this.user});

  @override
  ProductsListItemState createState() {
    return new ProductsListItemState();
  }
}

class ProductsListItemState extends State<ProductsListItem> {

  TextEditingController _c;

  void _showDialog(BuildContext context) {
    _c = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add to cart"),
            content: TextField(
              decoration: InputDecoration(labelText: "Enter quantity"),
              keyboardType: TextInputType.number,
              controller: _c,
            ),
            actions: <Widget>[
             ScopedModelDescendant<CartModel>(builder: (context, child, model) =>

                 FlatButton(
                   child: Text("Add"),
                   onPressed: (){
                     Commande commande = Commande(product: widget.product, quantity: int.parse(_c.text), clientId: widget.user.uid);

                     model.addToCart(commande);

                     print(model.cartProducts.length);
                     Navigator.of(context).pop();
                   },
                 )
              ),

              FlatButton(
                child: Text("Cancel"),
                onPressed: (){

                  Navigator.of(context).pop();
                },
              )

            ],

            );
        }
    );
  }

  @override

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: product,)));
       // _showDialog(context);

        if(widget.product.selected) {
          Commande toRemove;
          CartModel.of(context).cartProducts.forEach((commande){
            if(commande.product == widget.product) {
              toRemove = commande;
            }
          });

          CartModel.of(context).removeFromCart(toRemove);
        } else {
          Commande commande = Commande(product: widget.product, quantity: 30, clientId: widget.user.uid);
          CartModel.of(context).addToCart(commande);
        }

        setState(() {
          widget.product.selected = ! widget.product.selected;
        });

      },
      child: Stack(
        children: <Widget>[
      Card(
      elevation: 4.0,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Image.asset("${widget.product.imageUrl}"),
              ),
              SizedBox(height: 8.0,),
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
                        Text("${widget.product.currentPrice} DH",
                          style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8.0,),
                        Text("${widget.product.originalPrice} DH",
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey, decoration: TextDecoration.lineThrough
                          ),
                        ),
                        SizedBox(width: 8.0,),
                        Text("${widget.product.discount}% off",
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        ),
                        SizedBox(height: 8.0,)
                      ],
                    )
                  ],
                ),
              )
            ],
          )
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: widget.product.selected ? Container(color: Colors.transparent) : Container()
      )
        ],
      ),
    );
  }
}
