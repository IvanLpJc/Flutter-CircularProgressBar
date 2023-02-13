import 'package:flutter/material.dart';

class AnimatedSquarePage extends StatelessWidget {
  const AnimatedSquarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: _AnimatedSquare()),
    );
  }
}

class _AnimatedSquare extends StatefulWidget {
  const _AnimatedSquare({
    super.key,
  });

  @override
  State<_AnimatedSquare> createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<_AnimatedSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  // Animations
  late Animation moveRight;
  late Animation moveUp;
  late Animation moveLeft;
  late Animation moveDown;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4500));

    moveRight = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.25, curve: Curves.linearToEaseOut)));

    moveUp = Tween(begin: 0.0, end: -100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.5, curve: Curves.linearToEaseOut)));

    moveLeft = Tween(begin: 0.0, end: -100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 0.75, curve: Curves.linearToEaseOut)));
    moveDown = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1, curve: Curves.linearToEaseOut)));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  // Widget build(BuildContext context) {
  //   controller.repeat();
  //   return AnimatedBuilder(
  //     animation: controller,
  //     child: const Square(),
  //     builder: (context, child) {
  //       return Transform.translate(
  //         offset: Offset(0, moveDown.value),
  //         child: Transform.translate(
  //           offset: Offset(moveLeft.value, 0),
  //           child: Transform.translate(
  //             offset: Offset(0, moveUp.value),
  //             child: Transform.translate(
  //                 offset: Offset(moveRight.value, 0), child: child),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget build(BuildContext context) {
    controller.repeat();
    return AnimatedBuilder(
      animation: controller,
      child: const Square(),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              moveRight.value + moveLeft.value, moveDown.value + moveUp.value),
          child: child,
        );
      },
    );
  }
}

class Square extends StatelessWidget {
  const Square({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.blue),
    );
  }
}
