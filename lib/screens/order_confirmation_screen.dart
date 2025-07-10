import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'order_tracking_screen.dart';
import '../utils/invoice_pdf.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String customerName;
  final String address;
  final List<Map<String, dynamic>> items;
  final int total;

  const OrderConfirmationScreen({
    super.key,
    required this.customerName,
    required this.address,
    required this.items,
    required this.total,
  });

  void showOrderNotification() {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'order_channel',
      'Order Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    FlutterLocalNotificationsPlugin().show(
      0,
      'Order Confirmed 🎉',
      'Your Gennie order has been placed successfully!',
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showOrderNotification());

    return Scaffold(
      appBar: AppBar(title: const Text("Order Confirmed"), automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text("Thank you for your order!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Estimated delivery: 25–30 min."),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Shipping Address:\n$customerName\n$address"),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
                );
              },
              icon: const Icon(Icons.delivery_dining),
              label: const Text("Track Order"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                generateInvoice(
                  context,
                  customer: customerName,
                  address: address,
                  items: items,
                  total: total,
                );
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("Download Invoice"),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Continue Shopping"),
            ),
          ],
        ),
      ),
    );
  }
}
