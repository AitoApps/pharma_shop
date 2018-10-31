import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/auth.dart' ;

import 'package:pharma_shop/widgets/products_list_item.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:pharma_shop/pages/cart_page.dart';
import 'package:pharma_shop/widgets/drawer_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
      currentPrice: 20,
      originalPrice: 25,
      discount: 25,
      imageUrl: 'images/cabas-papier-pharmacie.jpg',
    ),
    Product(
      name: "cartona 2",
      currentPrice: 25,
      originalPrice: 30,
      discount: 25,
      imageUrl: 'images/sac-papier-pharmacie1.jpg',
    ),
    Product(
      name: "cartona 3",
      currentPrice: 30,
      originalPrice: 35,
      discount: 20,
      imageUrl: 'images/sac-papier-pharmacie2.jpg',
    ),
    Product(
      name: "cartona 4",
      currentPrice: 35,
      originalPrice: 40,
      discount: 20,
      imageUrl: 'images/sac-papier-pharmacie3.jpg',
    )
  ];

  Future<List<String>> _getCartProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> res = prefs.getStringList('cart');

    //res == null ? commands = List() : commands = res;

    return res == null ? List() : res;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getCartProducts().then((items){
      setState(() {
        cartCount = items.length;
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _getCartProducts().then((items){
      setState(() {
        cartCount = items.length;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

  return Scaffold(
      appBar: AppBar(
        title: Text("List Product"),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(icon: Icon(Icons.shopping_cart, size: 40.0,), onPressed: (){
                print("cart cliked");
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(user: widget.user,)));
              }),
              CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.red,
                child: Text('$cartCount', style: TextStyle(color: Colors.white, fontSize: 12.0),),
              )

            ],
          ),
        ],
      ),
      drawer: DrawerMenu(user: widget.user,),
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

}
