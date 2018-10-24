import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/pages/login_page.dart';
import 'package:pharma_shop/auth.dart' ;

import 'package:pharma_shop/widgets/products_list_item.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:pharma_shop/pages/cart_page.dart';



class HomePage extends StatefulWidget {
  FirebaseUser user;

  HomePage({@required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  UserAuth userAuth = UserAuth();
  // List of products
  List<Product> products = [
    Product(
      name: "cartona kbira",
      currentPrice: 20,
      originalPrice: 30,
      discount: 25,
      imageUrl: 'images/cabas-papier-pharmacie.jpg',
    ),
    Product(
      name: "cartona kbira",
      currentPrice: 20,
      originalPrice: 30,
      discount: 25,
      imageUrl: 'images/sac-papier-pharmacie1.jpg',
    ),
    Product(
      name: "cartona kbira",
      currentPrice: 10,
      originalPrice: 15,
      discount: 20,
      imageUrl: 'images/sac-papier-pharmacie2.jpg',
    ),
    Product(
      name: "cartona kbira",
      currentPrice: 10,
      originalPrice: 15,
      discount: 20,
      imageUrl: 'images/sac-papier-pharmacie3.jpg',
    )
  ];

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

  return Scaffold(
      appBar: AppBar(
        title: Text("Hi ${widget.user.email}"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            print("cart cliked");
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
          }),
          FlatButton(
            child: Text("LogOut", style: TextStyle(color: Colors.white70),),
            onPressed: signOut

          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text('${widget.user.displayName}'),
                accountEmail: Text('${widget.user.email}'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.green,
                child: Image.network('${widget.user.photoUrl}'),
              ),
            ),
            Text("Log out"),
            Text("About")
          ],
        ),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: itemWidth/itemHeight,
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            ProductsListItem(product: products[0],),
            ProductsListItem(product: products[1]),
            ProductsListItem(product: products[2]),
            ProductsListItem(product: products[3]),
        ],
      )
    );
  }

  void signOut() async {
    await userAuth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
