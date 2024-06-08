import 'package:flutter/material.dart';
import 'package:tcc/config/colors.dart';

class CustomIconButton extends IconButton {
  static const surfaceColor = ThemeColors.surface;

  const CustomIconButton(
      {super.key,
      required onPressed,
      required super.icon,
      bool isButtonActive = true})
      : super(
          onPressed: isButtonActive ? onPressed : null,
          color: isButtonActive ? null : surfaceColor,
          visualDensity: VisualDensity.compact,
          highlightColor: isButtonActive ? null : Colors.transparent,
          splashColor: isButtonActive ? null : Colors.transparent,
          enableFeedback: isButtonActive,
        );
}
