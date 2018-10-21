import 'package:flutter/material.dart';
import 'package:pharma_shop/pages/product_detail_page.dart';

class ProductsListItem extends StatelessWidget {
  final String name;
  final int currentPrice;
  final int originalPrice;
  final int discount;
  final String imageUrl;

  ProductsListItem({
    this.name, this.currentPrice, this.originalPrice, this.discount, this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage()));
      },
      child: Card(
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Image.asset("$imageUrl"),
              ),
              SizedBox(height: 8.0,),
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
                        Text("$currentPrice DH",
                          style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8.0,),
                        Text("$originalPrice DH",
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey, decoration: TextDecoration.lineThrough
                          ),
                        ),
                        SizedBox(width: 8.0,),
                        Text("$discount% off",
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        ),
                        SizedBox(height: 8.0,)
                      ],
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
