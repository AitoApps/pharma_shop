import 'package:flutter/material.dart';
import 'package:pharma_shop/pages/product_detail_page.dart';
import 'package:pharma_shop/model/product.dart';

class ProductsListItem extends StatelessWidget {

  final Product product;

  ProductsListItem({@required this.product});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: product,)));
      },
      child: Card(
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Image.asset("${product.imageUrl}"),
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
                        Text("${product.currentPrice} DH",
                          style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8.0,),
                        Text("${product.originalPrice} DH",
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey, decoration: TextDecoration.lineThrough
                          ),
                        ),
                        SizedBox(width: 8.0,),
                        Text("${product.discount}% off",
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
