import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required List<Map<String, dynamic>> cartItems});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: cart.items.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (_, index) {
                final item = cart.items[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text("₹${item['price']} x ${item['quantity']}"),
                  trailing:
                      Text("₹${item['price'] * item['quantity']}"),
                );
              },
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: ₹${cart.totalAmount}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutScreen(
                            cartItems: cart.items,
                            totalAmount: cart.totalAmount,
                          ),
                        ),
                      );
                    },
                    child: const Text("Checkout"),
                  ),
                ],
              ),
            ),
    );
  }
}
