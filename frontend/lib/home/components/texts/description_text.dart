import 'package:flutter/material.dart';
import 'package:tcc/config/colors.dart';

class DescriptionText extends Text {
  const DescriptionText(super.data, {super.key});
  @override
  TextStyle? get style => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: ThemeColors.onPrimary,
      );
}
