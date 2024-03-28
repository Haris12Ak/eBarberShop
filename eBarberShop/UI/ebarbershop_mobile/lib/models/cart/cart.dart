import 'package:ebarbershop_mobile/models/proizvodi/proizvodi.dart';

class Cart {
  List<CartItem> items = [];
}

class CartItem {
  late Proizvodi proizvod;
  late int count;

  CartItem(this.proizvod, this.count);
}
