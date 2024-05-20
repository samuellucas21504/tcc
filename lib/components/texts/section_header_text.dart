import 'package:flutter/material.dart';
import 'package:tcc/constants/colors.dart';

class SectionHeaderText extends Text {
  const SectionHeaderText(super.data, {super.key, super.textAlign});

  @override
  TextStyle? get style => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ThemeColors.onPrimary,
      );
}
