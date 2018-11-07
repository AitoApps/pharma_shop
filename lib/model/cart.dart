import 'package:scoped_model/scoped_model.dart';
import 'package:pharma_shop/model/product.dart';
import 'package:flutter/material.dart';


class CartModel extends Model {
  int _totalPrice = 0;

  List<Commande> _cartProducts = [];

  List<Commande> get cartProducts => _cartProducts;
  int get totalPrice => _totalPrice;

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addToCart(Commande commande) {
    _cartProducts.add(commande);
    _totalPrice += commande.product.currentPrice * commande.quantity;

    notifyListeners();
  }

  void incrementQuantity(Commande commande) {
    int commandeIndex = cartProducts.indexOf(commande);

    commande.quantity++;

    _totalPrice += commande.product.currentPrice;

    this.updateCart(commande, commandeIndex);

    notifyListeners();

  }

  void decrementQuantity(Commande commande) {
    int commandeIndex = cartProducts.indexOf(commande);

    commande.quantity--;

    _totalPrice += commande.product.currentPrice ;

    this.updateCart(commande, commandeIndex);
    notifyListeners();
  }

  void removeFromCart(Commande commande) {
    int commandeIndex = cartProducts.indexOf(commande);
    _totalPrice -= commande.quantity * commande.product.currentPrice;

    _cartProducts.removeAt(commandeIndex);

    notifyListeners();
  }

  void clearCart() {
    _cartProducts.clear();
    _totalPrice = 0;

  }

  void updateCart(Commande newCommande, int commandeIndex) {

    _cartProducts.removeAt(commandeIndex);

    _cartProducts.insert(commandeIndex , newCommande);
  }

}
