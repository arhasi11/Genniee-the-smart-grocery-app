import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final int price;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          Expanded(child: Image.asset(imagePath, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text("₹$price", style: const TextStyle(color: Colors.green)),
          ElevatedButton(onPressed: onAdd, child: const Text("Add to Cart"))
        ],
      ),
    );
  }
}
