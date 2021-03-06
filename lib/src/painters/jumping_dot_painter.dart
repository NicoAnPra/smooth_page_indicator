import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/effects/jumping_dot_effect.dart';

import 'indicator_painter.dart';

class JumpingDotPainter extends IndicatorPainter {
  final JumpingDotEffect effect;

  JumpingDotPainter({
    @required this.effect,
    @required int count,
    @required double offset,
    @required bool isRTL,
  }) : super(offset, count, effect, isRTL);

  @override
  void paint(Canvas canvas, Size size) {
    // paint still dots
    super.paint(canvas, size);
    final activeDotPainter = Paint()..color = effect.activeDotColor;
    final dotOffset = offset - offset.toInt();
    double expansion = 0;
    if (dotOffset < .5) {
      expansion = dotOffset * effect.elevation;
    } else {
      expansion = (1 - dotOffset) * effect.elevation;
    }

    final bounds = _calcBounds(offset, expansion);

    RRect activeDot = RRect.fromLTRBR(
        bounds.left, bounds.top, bounds.right, bounds.bottom, dotRadius);
    canvas.drawRRect(activeDot, activeDotPainter);
  }

  Rect _calcBounds(num i, [double expansion = 0]) {
    final xPos = (i * (effect.dotWidth + effect.spacing));
    final yPos = (effect.dotHeight) / 2;
    final height = effect.dotHeight + expansion;
    final width = effect.dotWidth + expansion;
    return Rect.fromLTRB(
        xPos, yPos - height / 2, xPos + width, yPos + height / 2);
  }
}
