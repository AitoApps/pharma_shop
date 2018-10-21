import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/pages/login_page.dart';
import 'package:pharma_shop/auth.dart' ;

import 'package:pharma_shop/widgets/products_list_item.dart';



class HomePage extends StatefulWidget {
  FirebaseUser user;

  HomePage({@required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  UserAuth userAuth = UserAuth();

  List<String> imageNames = [
    'cabas-papier-pharmacie.jpg', 'sac-papier-pharmacie1.jpg',
    'sac-papier-pharmacie2.jpg', 'sac-papier-pharmacie3.jpg'
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
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){}),
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
            ProductsListItem(
              name: "cartona kbira",
              currentPrice: 20,
              originalPrice: 30,
              discount: 25,
              imageUrl: 'images/${imageNames[0]}',
            ),
            ProductsListItem(
              name: "cartona kbira",
              currentPrice: 20,
              originalPrice: 30,
              discount: 25,
              imageUrl: 'images/${imageNames[1]}',
            ),
            ProductsListItem(
              name: "cartona kbira",
              currentPrice: 10,
              originalPrice: 15,
              discount: 20,
              imageUrl: 'images/${imageNames[2]}',
            ),
            ProductsListItem(
              name: "cartona kbira",
              currentPrice: 10,
              originalPrice: 15,
              discount: 20,
              imageUrl: 'images/${imageNames[3]}',
            )
        ],
      )
    );
  }

  void signOut() async {
    await userAuth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
