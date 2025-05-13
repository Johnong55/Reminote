import 'package:flutter/material.dart';

class MotivationalText extends StatelessWidget {
  final int streak;
  final bool isCompleted;

  const MotivationalText({super.key, required this.streak, required this.isCompleted});

  String _getText(int streak) {
    if(isCompleted) return 'Great job! You completed your tasks today!';
    if(!isCompleted)  return "You nearly miss today! Hurry up !!!";
    if (streak == 0) return 'Start your streak today!';
    if (streak < 3) return 'Good start, keep going!';
    if (streak < 7) return 'Great work, keep it up!';
    if (streak < 14) return 'You\'re on fire!';
    if (streak < 30) return 'Incredible consistency!';
    
    return 'You\'re unstoppable!';
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      child: Text(
        _getText(streak),
        style: textTheme.titleMedium?.copyWith(color: color),
        textAlign: TextAlign.center,
      ),
    );
  }
}
