import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharma_shop/model/client.dart';
import 'package:pharma_shop/adminPages/admin_client_detail_page.dart';

class AdminClientPage extends StatefulWidget {
  @override
  _AdminClientPageState createState() => _AdminClientPageState();
}

class _AdminClientPageState extends State<AdminClientPage> {

  List<FirebaseUser> users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("admin_client_page");

    //clients = [];
  }

  Stream<List<Client>> getClients() {
     List<Client> clients = List();
    return Firestore.instance.collection("users").getDocuments()
        .then((querySnapshot){
          querySnapshot.documents.forEach((snapshot){
            try {
              clients.add( Client.fromSnapshot(snapshot));
            } catch (e) {
              print(e);
            }
          });
       return clients;
    }).asStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clients List"),
      ),
      body: StreamBuilder<List<Client>>(
          stream: getClients(),
          builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {

            if (!snapshot.hasData) return Text("There is no clients");
            final List<Client> clients = snapshot.data;
            return ListView.builder(
                itemCount: clients.length, //userData.length,
                itemBuilder: (BuildContext context, int index) {
                   final Client client = clients[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(width: 1.0, color: Colors.black12)
                        )
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(client.image),
                      ),
                    ),
                    title: Text(client.name),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.email),

                            Text(client.email)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.shopping_basket),

                            Text("30")
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right), iconSize: 30.0, onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminClientDetailPage(client: client,)));
                    })
                    //Icon(Icons.keyboard_arrow_right, size: 30.0,),
                  );
                }
            );
         }
      )
    );
  }
}
