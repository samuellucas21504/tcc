import 'package:flutter/material.dart';

class RectangularRoundButton extends StatelessWidget {
  const RectangularRoundButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isInProgess = false,
    this.isValid = true,
  });

  final VoidCallback onPressed;
  final Widget child;

  final bool isInProgess;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: isValid ? onPressed : null,
      child: isInProgess
          ? const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            )
          : child,
    );
  }
}
