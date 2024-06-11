import 'package:flutter/material.dart';

class PaddedScrollView extends StatelessWidget {
  const PaddedScrollView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.1;

    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 25),
        child: child,
      ),
    );
  }
}
