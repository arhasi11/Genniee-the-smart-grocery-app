import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  // ignore: prefer_final_fields
  int _currentStep = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Track Order")),
      body: Stepper(
        currentStep: _currentStep,
        controlsBuilder: (context, _) => const SizedBox(),
        steps: const [
          Step(title: Text("Order Confirmed"), content: Text("We received your order."), state: StepState.complete, isActive: true),
          Step(title: Text("Packed"), content: Text("Your items are packed."), state: StepState.complete, isActive: true),
          Step(title: Text("Out for Delivery"), content: Text("Delivery partner is on the way."), state: StepState.editing, isActive: true),
          Step(title: Text("Delivered"), content: Text("Order delivered."), state: StepState.indexed, isActive: false),
        ],
      ),
    );
  }
}
