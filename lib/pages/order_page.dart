import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharma_shop/widgets/drawer_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                          String orderId = documants[index].documentID;
                          Map<String, dynamic> order = documants[index].data;
                          return  buildOrderCard(order, orderId);
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
                          String orderId = documants[index].documentID;
                          Map<String, dynamic> order = documants[index].data;
                          return  buildOrderCard(order, orderId);
                        });
                  }),
            ]
        )
      ),
    );
  }

  Card buildOrderCard(Map<String, dynamic> order, String orderId) {

    String name = order['name'].toString();
    int currentPrice = order['price'];
    int quantity = order['quantity'];
    String imageUrl = order['image_url'].toString();
    String clientId = order['user_id'].toString();
    String status = order['status'].toString();

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
                              IconButton(
                                onPressed: (){
                                  Firestore.instance.collection('orders').document(orderId)
                                      .delete().then((_){
                                    setState(() {

                                    });
                                  });

                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
  }
}
