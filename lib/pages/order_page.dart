import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharma_shop/widgets/drawer_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/model/product.dart';

enum OrderStatus {
  pending, shipped, completed
}

class OrderPage extends StatefulWidget {

  FirebaseUser user;

  OrderPage({@required this.user});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Orders "),
          bottom: TabBar(
              tabs: [
                Tab(child: Text("Pending"),),
                Tab(child: Text("Completed"),)
              ]
          ),
        ),
        drawer: DrawerMenu(user: widget.user,),
        body: TabBarView(
            children: [
              StreamBuilder(
                  stream: Firestore.instance.collection('orders').where("status", isEqualTo: "pending").snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    final List<DocumentSnapshot> documants = snapshot.data.documents;
                    return ListView.builder(
                        itemCount: documants.length,
                        itemBuilder: (BuildContext context, int index) {
                          String name = documants[index].data['name'].toString();
                          int currentPrice = documants[index].data['price'];
                          int quantity = documants[index].data['quantity'];
                          String imageUrl = documants[index].data['image_url'].toString();

                          return  buildOrderCard(imageUrl, name, currentPrice, quantity);
                        });
                  }),
              StreamBuilder(
                  stream: Firestore.instance.collection('orders').where("status", isEqualTo: "completed").snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    final List<DocumentSnapshot> documants = snapshot.data.documents;
                    return ListView.builder(
                        itemCount: documants.length,
                        itemBuilder: (BuildContext context, int index) {
                          String name = documants[index].data['name'].toString();
                          int currentPrice = documants[index].data['price'];
                          int quantity = documants[index].data['quantity'];
                          String imageUrl = documants[index].data['image_url'].toString();

                          return  buildOrderCard(imageUrl, name, currentPrice, quantity);
                        });
                  }),
            ]
        )
      ),
    );
  }

  Card buildOrderCard(String imageUrl, String name, int currentPrice, int quantity) {
    return Card(
                    elevation: 4.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 200.0,
                            child: Image.asset('$imageUrl')
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                //color: Colors.green,
                                child: Center(
                                  child: Text(name, style: TextStyle(
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
                                  Text('$currentPrice dh')
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text('quantity : ', style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(width: 20.0,),
                                  Text('$quantity ')
                                ],
                              ),
                              SizedBox(height: 20.0,),
                              Row(
                                children: <Widget>[
                                  Text('facture   :', style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(width: 20.0,),
                                  Text('${currentPrice * quantity} dh')
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Container(height: 0.5, color: Colors.grey,),
                              SizedBox(height: 5.0,),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: IconButton(
                                      onPressed: (){

                                      },
                                      icon: Icon(Icons.plus_one),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: (){

                                      },
                                      icon: Icon(Icons.exposure_neg_1),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: (){

                                      },
                                      icon: Icon(Icons.delete),
                                    ),
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
}
