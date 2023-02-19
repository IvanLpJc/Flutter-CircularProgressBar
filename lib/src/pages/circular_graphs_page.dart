import 'package:animated_custom_painter/src/widgets/radial_progress_indicator.dart';
import 'package:flutter/material.dart';

class CircularGraphsPage extends StatefulWidget {
  @override
  State<CircularGraphsPage> createState() => _CircularGraphsPageState();
}

class _CircularGraphsPageState extends State<CircularGraphsPage> {
  double percentage = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(
                  percentage: percentage, arcColor: Colors.amber),
              CustomRadialProgress(
                percentage: percentage,
                arcColor: Colors.red,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(
                percentage: percentage,
                arcColor: Colors.blue,
              ),
              CustomRadialProgress(
                percentage: percentage,
                arcColor: Colors.black,
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          percentage += 10;
          if (percentage > 100) {
            percentage = 0.0;
          }
        }),
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  CustomRadialProgress({
    super.key,
    required this.percentage,
    required this.arcColor,
  });

  final double percentage;
  final Color arcColor;

  final Gradient gradient =
      LinearGradient(colors: [Colors.red, Colors.blue, Colors.amber]);

  @override
  Widget build(BuildContext context) {
    return RadialProgressIndicator(
      width: 150,
      height: 150,
      arcColor: arcColor,
      percentage: percentage,
      showGuide: false,
      showPercetage: true,
    );
  }
}
