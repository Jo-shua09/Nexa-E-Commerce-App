import 'package:flutter/material.dart';
import 'package:nexa/core/theme/app_colors.dart';

class CustomRangeThumbShape extends RangeSliderThumbShape {
  const CustomRangeThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(18, 18);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final canvas = context.canvas;
    final fillPaint = Paint()..color = AppColors.white;
    final borderPaint = Paint()
      ..color = AppColors.gray900
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, 9, fillPaint);
    canvas.drawCircle(center, 9, borderPaint);
  }
}
