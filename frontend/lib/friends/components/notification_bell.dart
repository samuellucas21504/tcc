import 'package:flutter/material.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, required this.notificationQuantity});

  final int notificationQuantity;

  @override
  Widget build(BuildContext context) {
    if (notificationQuantity == 0) {
      return const Icon(Icons.notifications);
    }

    return Stack(
      children: [
        const Icon(
          Icons.notifications,
        ),
        Container(
          width: 15,
          height: 15,
          alignment: Alignment.topRight,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffc32c37),
          ),
          child: Center(
            child: Text(
              notificationQuantity.toString(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }
}
