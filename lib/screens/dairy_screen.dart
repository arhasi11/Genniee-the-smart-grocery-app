import 'package:flutter/material.dart';
import 'package:gennie_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class DairyScreen extends StatefulWidget {
  const DairyScreen({super.key, required this.onAddToCart});
  final Function(List<Map<String, dynamic>>) onAddToCart;

  @override
  State<DairyScreen> createState() => _DairyScreenState();
}

class _DairyScreenState extends State<DairyScreen> {
  List<Map<String, dynamic>> _dairyItems = [];
  List<Map<String, dynamic>> _filteredItems = [];

  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'None';

  final List<Map<String, dynamic>> _allItems = [
    {'name': 'Cow Milk', 'price': 50, 'quantity': 0},
    {'name': 'Buffalo Milk', 'price': 55, 'quantity': 0},
    {'name': 'A2 Milk', 'price': 80, 'quantity': 0},
    {'name': 'Lactose-Free Milk', 'price': 90, 'quantity': 0},
    {'name': 'Organic Milk', 'price': 70, 'quantity': 0},
    {'name': 'UHT Packaged Milk', 'price': 60, 'quantity': 0},
    {'name': 'Soy Milk', 'price': 65, 'quantity': 0},
    {'name': 'Almond Milk', 'price': 100, 'quantity': 0},
    {'name': 'Oat Milk', 'price': 95, 'quantity': 0},
    {'name': 'Full Cream Curd', 'price': 45, 'quantity': 0},
    {'name': 'Low-Fat Curd', 'price': 40, 'quantity': 0},
    {'name': 'Greek Yogurt', 'price': 60, 'quantity': 0},
    {'name': 'Probiotic Yogurt', 'price': 65, 'quantity': 0},
    {'name': 'Fruit Yogurt', 'price': 70, 'quantity': 0},
    {'name': 'White Butter', 'price': 90, 'quantity': 0},
    {'name': 'Table Butter', 'price': 95, 'quantity': 0},
    {'name': 'Organic Ghee', 'price': 140, 'quantity': 0},
    {'name': 'Desi Ghee', 'price': 160, 'quantity': 0},
    {'name': 'Vanaspati Ghee', 'price': 100, 'quantity': 0},
    {'name': 'Mozzarella Cheese', 'price': 130, 'quantity': 0},
    {'name': 'Cheddar Cheese', 'price': 135, 'quantity': 0},
    {'name': 'Cream Cheese', 'price': 120, 'quantity': 0},
    {'name': 'Parmesan Cheese', 'price': 150, 'quantity': 0},
    {'name': 'Paneer', 'price': 110, 'quantity': 0},
    {'name': 'Cheese Cubes', 'price': 85, 'quantity': 0},
    {'name': 'Pizza Cheese', 'price': 125, 'quantity': 0},
    {'name': 'Spiced Buttermilk', 'price': 20, 'quantity': 0},
    {'name': 'Salted Buttermilk', 'price': 18, 'quantity': 0},
    {'name': 'Sweet Lassi', 'price': 25, 'quantity': 0},
    {'name': 'Mango Lassi', 'price': 30, 'quantity': 0},
    {'name': 'Cold Coffee with Milk', 'price': 40, 'quantity': 0},
    {'name': 'Flavored Milkshakes', 'price': 35, 'quantity': 0},
    {'name': 'Milk Powder', 'price': 90, 'quantity': 0},
    {'name': 'Condensed Milk', 'price': 110, 'quantity': 0},
    {'name': 'Evaporated Milk', 'price': 95, 'quantity': 0},
    {'name': 'Tetra Pack Paneer', 'price': 120, 'quantity': 0},
  ];

  @override
  void initState() {
    super.initState();
    _dairyItems = List.from(_allItems);
    _filteredItems = List.from(_allItems);
    _searchController.addListener(_applySearchAndFilter);
  }

  void _applySearchAndFilter() {
    String query = _searchController.text.toLowerCase();
    List<Map<String, dynamic>> items = _dairyItems.where((item) {
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
      appBar: AppBar(title: const Text("Dairy")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Dairy Products',
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
