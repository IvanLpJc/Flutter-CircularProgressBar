import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RadialProgressIndicator extends StatefulWidget {
  final double percentage;
  final double width;
  final double height;
  final Color? arcColor;
  final Color? guideColor;
  final Color? textColor;
  final Gradient? arcGradient;
  final bool showPercetage;
  final bool showGuide;
  final double arcWidth;
  final double guideWidth;
  const RadialProgressIndicator(
      {super.key,
      required this.percentage,
      required this.width,
      required this.height,
      this.arcColor,
      this.guideColor,
      this.arcGradient,
      this.textColor,
      this.showPercetage = true,
      this.showGuide = true,
      this.guideWidth = 1,
      this.arcWidth = 10});

  @override
  State<RadialProgressIndicator> createState() =>
      _RadialProgressIndicatorState();
}

class _RadialProgressIndicatorState extends State<RadialProgressIndicator>
    with SingleTickerProviderStateMixin {
  double get percentage => widget.percentage;

  Color? get arcColor => widget.arcColor;

  Color? get guideColor => widget.guideColor;

  Color? get textColor => widget.textColor;

  Gradient? get arcGradient => widget.arcGradient;

  bool get showPercentage => widget.showPercetage;

  bool get showGuide => widget.showGuide;

  double get arcWidth => widget.arcWidth;

  double get guideWidth => widget.guideWidth;

  double get width => widget.width;
  double get height => widget.height;

  late AnimationController controller;
  late double prevPercentage;

  @override
  void initState() {
    prevPercentage = percentage;
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);

    final differenceToAnimate = percentage - prevPercentage;
    prevPercentage = percentage;

    final textSize = width > height ? height / 10 : width / 10;
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double percentageToAnimate = (percentage - differenceToAnimate) +
              (differenceToAnimate * controller.value);
          return Container(
            padding: const EdgeInsets.all(10),
            width: width,
            height: height,
            child: CustomPaint(
              painter: _RadialProgressPainter(
                  percentageToAnimate,
                  arcColor ?? Theme.of(context).colorScheme.primary,
                  guideColor ?? Theme.of(context).colorScheme.secondary,
                  showGuide,
                  arcWidth,
                  guideWidth,
                  arcGradient),
              child: showPercentage
                  ? Center(
                      child: Text(
                        '${percentageToAnimate.toStringAsFixed(2)} %',
                        style: TextStyle(fontSize: textSize, color: textColor),
                      ),
                    )
                  : Container(),
            ),
          );
        });
  }
}

class _RadialProgressPainter extends CustomPainter {
  final double percentage;
  final Color arcColor;
  final Color guideColor;
  final bool showGuide;
  final double arcWidth;
  final double guideWidth;
  final Gradient? gradient;

  _RadialProgressPainter(this.percentage, this.arcColor, this.guideColor,
      this.showGuide, this.arcWidth, this.guideWidth, this.gradient);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect gradientRect =
        Rect.fromCircle(center: Offset(0, 0), radius: 100);

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * 0.5);
    // Complete circle
    if (showGuide) {
      final paint = Paint()
        ..strokeWidth = guideWidth
        ..color = guideColor
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(center, radius, paint);
    }

    //arc
    final arcPaint = Paint()
      ..strokeWidth = arcWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (gradient != null) {
      arcPaint.shader = gradient!.createShader(gradientRect);
    } else {
      arcPaint.color = arcColor;
    }

    //Part that will be filled
    double arcAngle = 2 * pi * (percentage / 100);
    // Space where we'll place the arc
    Rect rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(rect, -pi / 2, arcAngle, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
