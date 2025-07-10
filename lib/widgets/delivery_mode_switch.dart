import 'package:flutter/material.dart';

class DeliveryModeSwitch extends StatelessWidget {
  const DeliveryModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("Express\n10–15 min", textAlign: TextAlign.center),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("Eco Slot\n2–4 hr", textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}
