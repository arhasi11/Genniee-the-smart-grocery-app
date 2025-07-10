class CartModel {
  static final List<Map<String, dynamic>> items = [];

  static void addItem(Map<String, dynamic> product) {
    items.add(product);
  }

  static void removeItem(int index) {
    items.removeAt(index);
  }

  static void clear() {
    items.clear();
  }

  static int get totalItems => items.length;

  static double get totalPrice => items.fold(
      0, (sum, item) => sum + (item['price'] as num).toDouble());
}
