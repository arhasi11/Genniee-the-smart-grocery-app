import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  final List<Map<String, dynamic>> _orders = const [
    {
      'id': 'ORD123',
      'date': '2025-07-01',
      'items': ['Milk', 'Bread', 'Butter'],
      'total': 320
    },
    {
      'id': 'ORD124',
      'date': '2025-07-04',
      'items': ['Rice', 'Sugar'],
      'total': 250
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: _orders.isEmpty
          ? const Center(child: Text("No orders yet."))
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (_, index) {
                final order = _orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text("Order ID: ${order['id']}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date: ${order['date']}"),
                        Text("Items: ${order['items'].join(', ')}"),
                        Text("Total: ₹${order['total']}"),
                      ],
                    ),
                    trailing: const Icon(Icons.receipt_long),
                  ),
                );
              },
            ),
    );
  }
}
