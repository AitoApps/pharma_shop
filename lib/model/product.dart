import 'dart:convert';

class Product {
  final String name;
  final int currentPrice;
  final int originalPrice;
  final int discount;
  final String imageUrl;

  Product({this.name, this.currentPrice, this.originalPrice, this.discount, this.imageUrl});

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'currentPrice': currentPrice,
        'originalPrice': originalPrice,
        'discount': discount,
        'imageUrl': imageUrl
      };
}



class Commande {
  final Product product;
  final int quantity;

  Commande(this.product, this.quantity);

  Map<String, dynamic> toJson() =>
      {
        'quantity': quantity,
        'product': product.toJson(),
      };
}