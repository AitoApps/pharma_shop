import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/pages/login_page.dart';
import 'package:pharma_shop/auth.dart' ;



class HomePage extends StatefulWidget {
  FirebaseUser user;

  HomePage({@required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  UserAuth userAuth = UserAuth();

  @override
  Widget build(BuildContext context) {

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
      body: Center(
        child: Text("All products"),
      ),
    );
  }

  void signOut() async {
    await userAuth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
