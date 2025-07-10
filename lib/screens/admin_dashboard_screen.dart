import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Admin Dashboard"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Products', icon: Icon(Icons.shopping_cart)),
              Tab(text: 'Orders', icon: Icon(Icons.receipt_long)),
              Tab(text: 'Users', icon: Icon(Icons.people)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProductsTab(),
            OrdersTab(),
            UsersTab(),
          ],
        ),
      ),
    );
  }
}

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  final List<Map<String, dynamic>> _products = [
    {'name': 'Milk 1L', 'price': 45},
    {'name': 'Tomatoes', 'price': 30},
  ];

  void _addProduct(String name, int price) {
    setState(() {
      _products.add({'name': name, 'price': price});
    });
  }

  void _editProduct(int index, String newName, int newPrice) {
    setState(() {
      _products[index] = {'name': newName, 'price': newPrice};
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _showProductDialog({int? editIndex}) {
    final nameController = TextEditingController(
      text: editIndex != null ? _products[editIndex]['name'] : '',
    );
    final priceController = TextEditingController(
      text: editIndex != null ? _products[editIndex]['price'].toString() : '',
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(editIndex == null ? "Add Product" : "Edit Product"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final price = int.tryParse(priceController.text.trim()) ?? 0;

              if (editIndex == null) {
                _addProduct(name, price);
              } else {
                _editProduct(editIndex, name, price);
              }

              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _products.isEmpty
          ? const Center(child: Text("No products yet"))
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text("₹${product['price']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showProductDialog(editIndex: index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteProduct(index),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProductDialog(),
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        tooltip: "Add Product",
      ),
    );
  }
}

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Orders coming soon"));
  }
}

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Users coming soon"));
  }
}
