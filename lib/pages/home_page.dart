import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/pages/login_page.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  HomePage({@required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi ${widget.user.email}"),
        actions: <Widget>[
          FlatButton(
            child: Text("LogOut", style: TextStyle(color: Colors.white70),),
            onPressed: signOut

          )
        ],
      ),
      body: Center(
        child: Text("All products"),
      ),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
