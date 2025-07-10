import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final int totalAmount;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = 'John Doe';
  String _street = '123, MG Road';
  String _city = 'Raipur';
  String _pincode = '492001';

  void _placeOrder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OrderConfirmationScreen(
            customerName: _name,
            address: '$_street, $_city - $_pincode',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Delivery Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _name,
                    decoration: const InputDecoration(labelText: "Full Name"),
                    onSaved: (value) => _name = value!,
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    initialValue: _street,
                    decoration:
                        const InputDecoration(labelText: "Street Address"),
                    onSaved: (value) => _street = value!,
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    initialValue: _city,
                    decoration: const InputDecoration(labelText: "City"),
                    onSaved: (value) => _city = value!,
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    initialValue: _pincode,
                    decoration: const InputDecoration(labelText: "PIN Code"),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _pincode = value!,
                    validator: (value) =>
                        value!.length != 6 ? "Enter valid 6-digit PIN" : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...widget.cartItems.map((item) => ListTile(
                  title: Text(item['name']),
                  trailing:
                      Text("₹${item['price']} x ${item['quantity']}"),
                )),
            const Divider(thickness: 1.2),
            ListTile(
              title: const Text("Total",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text("₹${widget.totalAmount}",
                  style: const TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle),
              label: const Text("Place Order"),
              onPressed: _placeOrder,
            )
          ],
        ),
      ),
    );
  }
}

class OrderConfirmationScreen extends StatelessWidget {
  final String customerName;
  final String address;

  const OrderConfirmationScreen({
    super.key,
    required this.customerName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Confirmed"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Thank you for your order!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text("Your order has been confirmed."),
            const SizedBox(height: 6),
            const Text("Estimated delivery: 25–30 min."),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Shipping Address",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("$customerName\n$address"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child:
                  const Text("Continue Shopping", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
