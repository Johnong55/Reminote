import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StreakAnimation extends StatelessWidget {
  const StreakAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 140,
      child: Lottie.asset(
        'assets/lottie/fire.json',
        fit: BoxFit.contain,
      ),
    );
  }
}
