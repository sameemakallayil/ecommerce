// lib/Service/cart_service.dart
import 'package:ecommerce/model/Products.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Products> _cartItems = [];

  List<Products> get cartItems => _cartItems;

  void addToCart(Products product) {
    _cartItems.add(product);
  }

  void removeFromCart(Products product) {
    _cartItems.remove(product);
  }

  void clearCart() {
    _cartItems.clear();
  }
}
