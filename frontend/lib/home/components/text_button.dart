import 'package:flutter/material.dart';

class InteractiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const InteractiveButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            child: Text(
              text,
            ),
          ),
        )
      ],
    );
  }
}
