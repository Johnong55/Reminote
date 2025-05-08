import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StreakAnimation extends StatelessWidget {
  final bool? isCompleted;
  const StreakAnimation({super.key,required this.isCompleted});

  @override
  Widget build(BuildContext context) {

    return isCompleted == true ? SizedBox(
      height: 80,
      width: 80,
      child: Lottie.asset(
        'assets/lottie/fire.json',
        fit: BoxFit.contain,
        
      ),
    ): SizedBox(
      height: 80,
      width: 80,
      child: Lottie.asset(
        'assets/lottie/offire.json',
        fit: BoxFit.contain,

      ),
    ); 
  }
}