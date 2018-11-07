import 'package:flutter/material.dart';
import 'package:pharma_shop/pages/login_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:pharma_shop/model/cart.dart';




void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CartModel>(
      model: CartModel(),
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    ));
  }
}