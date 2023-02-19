import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  const CircularProgressPage({super.key});

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  double percentage = 0.0;
  double newPercentage = 0.0;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    controller.addListener(() {
      setState(() {
        percentage = lerpDouble(percentage, newPercentage, controller.value)!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          height: 300,
          width: 300,
          child: CustomPaint(
            painter: _RadialProgressPainter(percentage: percentage),
            child: Center(
              child: Text(
                '${percentage.toStringAsFixed(2)} %',
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              percentage = newPercentage;
              newPercentage += 10;
              if ((newPercentage += 10) > 100) {
                newPercentage = 0;
                controller.reverse();
              }
              controller.forward(from: 0.0);
            });
          }),
    );
  }
}

class _RadialProgressPainter extends CustomPainter {
  final double percentage;

  _RadialProgressPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    // Complete circle
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    //arc
    final arcPaint = Paint()
      ..strokeWidth = 10
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;

    //Part that will be filled
    double arcAngle = 2 * pi * (percentage / 100);
    // Space where we'll place the arc
    Rect rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(rect, -pi / 2, arcAngle, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
