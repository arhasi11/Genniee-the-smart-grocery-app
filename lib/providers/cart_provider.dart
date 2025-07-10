import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> item) {
    int index = _items.indexWhere((e) => e['name'] == item['name']);
    if (index >= 0) {
      _items[index]['quantity'] += item['quantity'];
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int get totalAmount {
    return _items.fold(0, (sum, item) =>
        sum + (item['price'] as int) * (item['quantity'] as int));
  }
}
