import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharma_shop/pages/login_page.dart';


//final Future<FirebaseApp> app =  FirebaseApp.configure(
//    name: null,
//    options: FirebaseOptions(
//        googleAppID: '1:718038542105:android:5b35c4e24a6f7cd6',
//        apiKey: 'AIzaSyDnbRarZxzLGb3Vdg78BRxz6fvXclacwEg',
//        databaseURL: ''
//    )
//);
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}