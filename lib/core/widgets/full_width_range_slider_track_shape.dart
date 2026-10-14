import 'package:flutter/material.dart';

class FullWidthRangeSliderTrackShape extends RoundedRectRangeSliderTrackShape {
  const FullWidthRangeSliderTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 2.0;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackLeft = offset.dx;
    final double trackWidth = parentBox.size.width;

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
