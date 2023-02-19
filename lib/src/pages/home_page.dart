import 'package:animated_custom_painter/src/challenges/animated_square_page.dart';
import 'package:animated_custom_painter/src/widgets/headers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  List<String> titles = [
    'Squared header',
    'Rounded header',
    'Diagonal header',
    'Full diagonal',
    'Triangle header',
    'Wave header',
    'Animated square'
  ];
  Gradient gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0Xff6D05E8), Color(0xffC012FF), Color(0xff6D05FA)],
      stops: [0.0, 0.4, 1.0]);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: currentPage == 5 ? gradient : null,
                  color: currentPage != 5 ? const Color(0xff615AAB) : null),
            ),
            title: Text(
              titles[currentPage],
              style: const TextStyle(color: Colors.white),
            )),
        body: PageView(
          onPageChanged: (value) => setState(() {
            currentPage = value;
          }),
          physics: const BouncingScrollPhysics(),
          children: [
            const SquaredHeader(),
            const RoundedBorderHeader(),
            DiagonalHeader(headerType: 0),
            DiagonalHeader(headerType: 1),
            DiagonalHeader(headerType: 2),
            const CurvedHeader(),
            const AnimatedSquarePage()
          ],
        ),
      ),
    );
  }
}
