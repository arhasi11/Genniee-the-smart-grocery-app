import 'package:flutter/material.dart';
import 'package:gennie_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class FruitsScreen extends StatefulWidget {
  const FruitsScreen({super.key, required this.onAddToCart});
  final Function(List<Map<String, dynamic>>) onAddToCart;

  @override
  State<FruitsScreen> createState() => _FruitsScreenState();
}

class _FruitsScreenState extends State<FruitsScreen> {
  List<Map<String, dynamic>> _fruitItems = [];
  List<Map<String, dynamic>> _filteredItems = [];

  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'None';

  final List<Map<String, dynamic>> _allItems = [
    {'name': 'Apple', 'price': 120, 'quantity': 0},
    {'name': 'Banana', 'price': 40, 'quantity': 0},
    {'name': 'Orange', 'price': 60, 'quantity': 0},
    {'name': 'Mango', 'price': 100, 'quantity': 0},
    {'name': 'Grapes', 'price': 70, 'quantity': 0},
    {'name': 'Papaya', 'price': 50, 'quantity': 0},
    {'name': 'Watermelon', 'price': 80, 'quantity': 0},
    {'name': 'Pomegranate', 'price': 90, 'quantity': 0},
    {'name': 'Kiwi', 'price': 110, 'quantity': 0},
    {'name': 'Strawberry', 'price': 150, 'quantity': 0},
  ];

  @override
  void initState() {
    super.initState();
    _fruitItems = List.from(_allItems);
    _filteredItems = List.from(_allItems);
    _searchController.addListener(_applySearchAndFilter);
  }

  void _applySearchAndFilter() {
    String query = _searchController.text.toLowerCase();
    List<Map<String, dynamic>> items = _fruitItems.where((item) {
      return item['name'].toLowerCase().contains(query);
    }).toList();

    if (_selectedFilter == 'Price: Low to High') {
      items.sort((a, b) => a['price'].compareTo(b['price']));
    } else if (_selectedFilter == 'Price: High to Low') {
      items.sort((a, b) => b['price'].compareTo(a['price']));
    }

    setState(() {
      _filteredItems = items;
    });
  }

  void _changeFilter(String? value) {
    if (value == null) return;
    setState(() {
      _selectedFilter = value;
    });
    _applySearchAndFilter();
  }

  void _addItem(int index) {
    setState(() => _filteredItems[index]['quantity']++);
  }

  void _removeItem(int index) {
    setState(() {
      if (_filteredItems[index]['quantity'] > 0) {
        _filteredItems[index]['quantity']--;
      }
    });
  }

  void _addToCart() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    for (var item in _filteredItems) {
      if (item['quantity'] > 0) {
        cart.addItem({
          'name': item['name'],
          'price': item['price'],
          'quantity': item['quantity'],
        });
        item['quantity'] = 0;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Items added to cart")),
    );
    _applySearchAndFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fruits")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Fruits',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              value: _selectedFilter,
              decoration: const InputDecoration(labelText: "Filter by"),
              items: const [
                DropdownMenuItem(value: 'None', child: Text('None')),
                DropdownMenuItem(value: 'Price: Low to High', child: Text('Price: Low to High')),
                DropdownMenuItem(value: 'Price: High to Low', child: Text('Price: High to Low')),
              ],
              onChanged: _changeFilter,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text("₹${item['price']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _removeItem(index),
                        ),
                        Text('${item['quantity']}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _addItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: _addToCart,
          icon: const Icon(Icons.shopping_cart_checkout),
          label: const Text("Add to Cart"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
