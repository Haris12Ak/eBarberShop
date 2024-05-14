import 'package:ebarbershop_mobile/models/cart/cart.dart';
import 'package:ebarbershop_mobile/models/proizvodi/proizvodi.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Cart cart = Cart();

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  set totalPrice(double newValue) {
    _totalPrice = newValue;
  }

  addToCart(Proizvodi proizvod) {
    if (isAlreadyExistProduct(proizvod)) {
      throw Exception("Proizvod dodan u košaricu");
    } else {
      cart.items.add(CartItem(proizvod, 1));
    }

    notifyListeners();
  }

  removeFromCart(Proizvodi proizvod) {
    cart.items.removeWhere(
        (element) => element.proizvod.proizvodiId == proizvod.proizvodiId);

    notifyListeners();
  }

  bool isAlreadyExistProduct(Proizvodi proizvod) {
    bool exist = cart.items
        .any((element) => element.proizvod.proizvodiId == proizvod.proizvodiId);

    return exist;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    notifyListeners();
  }

  int getCounter() {
    return cart.items.isEmpty ? 0 : cart.items.length;
  }
}
