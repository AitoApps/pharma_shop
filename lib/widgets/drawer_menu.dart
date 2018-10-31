import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/pages/order_page.dart';
import 'package:pharma_shop/pages/home_page.dart';
import 'package:pharma_shop/auth.dart';
import 'package:pharma_shop/pages/login_page.dart';
import 'package:pharma_shop/adminPages/admin_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharma_shop/adminPages/admin_client_page.dart';

class DrawerMenu extends StatelessWidget {

  final FirebaseUser user;

  UserAuth userAuth = UserAuth();

  DrawerMenu({@required this.user});

  void signOut(BuildContext context) async {
    await userAuth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('${user.displayName}'),
            accountEmail: Text('${user.email}'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.green,
              child: Image.network('${user.photoUrl}'),
            ),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text("Home",
                style: TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w400
                ),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(user: user)));
              }
          ),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text("My orders",
                style: TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w400
                ),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderPage(user: user)));
              }
          ),

          Divider(),

          ListTile(
              leading: Icon(Icons.desktop_mac),
              title: Text("Admin",
                style: TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w400
                ),
              ),
              onTap: (){
                userAuth.isAdmin(user).then((isAdmin){
                  print(isAdmin);
                  if (isAdmin)
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminHomePage()));
                });
              }
          ),
          ListTile(
              leading: Icon(Icons.people),
              title: Text("Clients",
                style: TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w400
                ),
              ),
              onTap: (){
                userAuth.isAdmin(user).then((isAdmin){
                  print(isAdmin);
                  if (isAdmin)
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminClientPage()));
                });
              }
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text("Sign out",
                style: TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w400
                ),
              ),
              onTap: (){
                signOut(context);
              }
          )

        ],
      ),
    );
  }
}
