import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final int currentPrice;
  final int originalPrice;
  final int discount;
  final String imageUrl;
  bool selected;

  Product({this.name, this.currentPrice, this.originalPrice, this.discount, this.imageUrl, this.selected});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      currentPrice: json['currentPrice'],
      originalPrice: json['originalPrice'],
      discount: json['discount'],
      imageUrl: json['imageUrl'],
      selected: json['selected']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'currentPrice': currentPrice,
        'originalPrice': originalPrice,
        'discount': discount,
        'imageUrl': imageUrl,
        'selected': selected
      };

  Product.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        currentPrice = snapshot['currentPrice'],
        originalPrice = snapshot['originalPrice'],
        discount = snapshot['discount'],
        imageUrl = snapshot['imageUrl'],
        selected = snapshot['selected'];
}

class Commande {
  final Product product;
   int quantity;
   String clientId;
   String status;

  Commande({this.product, this.quantity, this.clientId, this.status});

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande (
        product: Product.fromJson(json['product']),
        quantity: json['quantity'],
        clientId: json['clientId'],
        status: json['status']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'clientId': clientId,
        'quantity': quantity,
        'status': status,
        'product': product.toJson(),
      };

//  Commande.fromSnapshot(DocumentSnapshot snapshot)
//      : //product = Product.fromSnapshot(snapshot['product']),
//        quantity = snapshot['quantity'],
//        clientId =snapshot['clientId'],
//        status = snapshot['status'];
}