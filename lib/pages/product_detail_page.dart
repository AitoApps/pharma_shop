import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset("images/cabas-papier-pharmacie.jpg"),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("kartona diale dowa",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        SizedBox(height: 2.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("20 DH",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8.0,),
                            Text("3 DH",
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.grey, decoration: TextDecoration.lineThrough
                              ),
                            ),
                            SizedBox(width: 8.0,),
                            Text("40% off",
                              style: TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                            SizedBox(height: 8.0,)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(labelText: "Enter Quatity", labelStyle: TextStyle(
                fontSize: 16.0, fontWeight: FontWeight.bold
              )),
              keyboardType: TextInputType.number,
            ),
          ),

          RaisedButton(
            color: Colors.green,
            onPressed: (){},
            child: Text("Commander", style: TextStyle(fontSize: 20.0, color: Colors.white)),
          )

        ],
      ),
    );
  }
}
