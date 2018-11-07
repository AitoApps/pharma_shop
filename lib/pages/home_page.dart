import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/auth.dart' ;

import 'package:pharma_shop/widgets/products_list_item.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:pharma_shop/pages/cart_page.dart';
import 'package:pharma_shop/widgets/drawer_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pharma_shop/model/cart.dart';

class HomePage extends StatefulWidget {
  FirebaseUser user;

  HomePage({@required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int cartCount;
  UserAuth userAuth = UserAuth();
  // List of products
  List<Product> products = [
    Product(
      name: "cartona 1",
      currentPrice: 2,
      originalPrice: 25,
      discount: 25,
      imageUrl: 'images/cabas-papier-pharmacie.jpg',
      selected: false
    ),
    Product(
      name: "cartona 2",
      currentPrice: 4,
      originalPrice: 30,
      discount: 25,
      imageUrl: 'images/sac-papier-pharmacie1.jpg',
      selected: false
    ),
    Product(
      name: "cartona 3",
      currentPrice: 6,
      originalPrice: 35,
      discount: 20,
      imageUrl: 'images/sac-papier-pharmacie2.jpg',
      selected: false
    ),
    Product(
      name: "cartona 4",
      currentPrice: 8,
      originalPrice: 40,
      discount: 20,
      imageUrl: 'images/sac-papier-pharmacie3.jpg',
      selected: false
    )
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height -  kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

  return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Stack(
            children: <Widget>[
              Icon(Icons.shopping_cart, size: 40.0,),
              CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.red,
                  child:
                  ScopedModelDescendant<CartModel>(builder: (context, child, model) =>
                      Text(
                        model.cartProducts.length.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                  )
                //Text('$cartCount', style: TextStyle(color: Colors.white, fontSize: 12.0),),
              )
            ],
          ),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(user: widget.user,)));
          }
      ),
      appBar: AppBar(
        title: Text("List Product"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.wallpaper),
            title: new Text('Products'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.shop_two),
            title: new Text('My Orders'),
          ),
        ],
      ),
      drawer: DrawerMenu(user: widget.user,),
      body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: itemWidth/itemHeight,
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            ProductsListItem(product: products[0], user: widget.user),
            ProductsListItem(product: products[1], user: widget.user),
            ProductsListItem(product: products[2], user: widget.user),
            ProductsListItem(product: products[3], user: widget.user),
        ],
      )
    );
  }

}
