import 'package:flutter/material.dart';
import 'package:tcc/config/colors.dart';

class TitleText extends Text {
  const TitleText(super.data, {super.key, super.style, super.textAlign});

  @override
  TextStyle? get style => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ThemeColors.onPrimary,
      );
}
