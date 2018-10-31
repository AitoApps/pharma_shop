import 'dart:convert';

class Product {
  final String name;
  final int currentPrice;
  final int originalPrice;
  final int discount;
  final String imageUrl;

  Product({this.name, this.currentPrice, this.originalPrice, this.discount, this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      currentPrice: json['currentPrice'],
      originalPrice: json['originalPrice'],
      discount: json['discount'],
      imageUrl: json['imageUrl'],
    );
  }

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
  final String clientId;

  Commande({this.product, this.quantity, this.clientId});

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande (
        product: Product.fromJson(json['product']),
        quantity: json['quantity'],
        clientId: json['clientId']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'clientId': clientId,
        'quantity': quantity,
        'product': product.toJson(),
      };
}