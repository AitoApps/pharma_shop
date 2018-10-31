import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pharma_shop/widgets/drawer_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OrderPage extends StatefulWidget {

  FirebaseUser user;

  OrderPage({@required this.user});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      drawer: DrawerMenu(user: widget.user,),
      body: StreamBuilder(
          stream: Firestore.instance.collection('orders').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            final List<DocumentSnapshot> documants = snapshot.data.documents;
            return ListView.builder(
                itemCount: documants.length,
                itemBuilder: (BuildContext context, int index) {
                  String name = documants[index].data['name'].toString();
                  return Text("$name");
                });
          }),
    );
  }
}
