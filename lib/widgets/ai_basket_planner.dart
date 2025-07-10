import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart:math';

class AiBasketPlanner extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onAddToCart;

  const AiBasketPlanner({super.key, required this.onAddToCart});

  @override
  State<AiBasketPlanner> createState() => _AiBasketPlannerState();
}

class _AiBasketPlannerState extends State<AiBasketPlanner> {
  final TextEditingController _budgetController = TextEditingController();
  List<Map<String, dynamic>> _suggestedItems = [];
  // ignore: prefer_final_fields
  List<List<Map<String, dynamic>>> _savedBaskets = [];

  final List<Map<String, dynamic>> _allItems = [
    {'name': 'Milk', 'price': 50},
    {'name': 'Bread', 'price': 30},
    {'name': 'Eggs (6 pcs)', 'price': 40},
    {'name': 'Apples (1kg)', 'price': 120},
    {'name': 'Maggi Pack', 'price': 15},
    {'name': 'Cheese Cubes', 'price': 85},
    {'name': 'Butter', 'price': 70},
    {'name': 'Curd', 'price': 40},
    {'name': 'Bananas (1 dozen)', 'price': 60},
    {'name': 'Oats Packet', 'price': 50},
  ];

  void _generateBasketFromBudget() {
    final budget = int.tryParse(_budgetController.text.trim());
    if (budget == null || budget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid budget")),
      );
      return;
    }

    List<Map<String, dynamic>> selected = [];
    int remaining = budget;
    final items = List<Map<String, dynamic>>.from(_allItems)..shuffle();

    for (var item in items) {
      if (item['price'] <= remaining) {
        selected.add({...item, 'quantity': 1});
        remaining -= item['price'] as int;
      }
    }

    setState(() => _suggestedItems = selected);
  }

  void _increaseQty(int index) {
    setState(() => _suggestedItems[index]['quantity']++);
  }

  void _decreaseQty(int index) {
    setState(() {
      if (_suggestedItems[index]['quantity'] > 0) {
        _suggestedItems[index]['quantity']--;
      }
    });
  }

  void _addSelectedToCart() {
    final selectedItems =
        _suggestedItems.where((item) => item['quantity'] > 0).toList();
    if (selectedItems.isNotEmpty) {
      widget.onAddToCart(selectedItems);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Items added to cart')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No items selected')),
      );
    }
  }

  void _saveBasket() {
    if (_suggestedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Generate a basket first')),
      );
      return;
    }

    setState(() {
      _savedBaskets.add(List<Map<String, dynamic>>.from(_suggestedItems));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Basket saved')),
    );
  }

  void _addSavedBasketToCart(List<Map<String, dynamic>> basket) {
    widget.onAddToCart(basket);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved basket added to cart')),
    );
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "🧮 Smart Budget Basket",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter your budget (₹)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _generateBasketFromBudget,
                    child: const Text("Generate Basket"),
                  ),
                ),
                const SizedBox(width: 10),
                if (_suggestedItems.isNotEmpty)
                  ElevatedButton(
                    onPressed: _saveBasket,
                    child: const Icon(Icons.save),
                  ),
              ],
            ),
            if (_suggestedItems.isNotEmpty) const Divider(height: 20),
            if (_suggestedItems.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _suggestedItems.length,
                itemBuilder: (_, index) {
                  final item = _suggestedItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text("₹${item['price']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _decreaseQty(index),
                        ),
                        Text('${item['quantity']}'),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => _increaseQty(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            if (_suggestedItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton.icon(
                  onPressed: _addSelectedToCart,
                  icon: const Icon(Icons.shopping_cart_checkout),
                  label: const Text("Add Selected to Cart"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            if (_savedBaskets.isNotEmpty) const Divider(height: 20),
            if (_savedBaskets.isNotEmpty)
              const Text(
                "❤️ Saved Baskets",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            if (_savedBaskets.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _savedBaskets.length,
                itemBuilder: (_, index) {
                  final basket = _savedBaskets[index];
                  return ListTile(
                    title: Text("Basket ${index + 1}"),
                    subtitle: Text(
                      basket.map((e) => "${e['name']} x${e['quantity']}").join(", "),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () => _addSavedBasketToCart(basket),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
