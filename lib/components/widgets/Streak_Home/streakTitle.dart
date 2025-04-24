import 'package:flutter/material.dart';

class StreakTitle extends StatelessWidget {
  final int streak;

  const StreakTitle({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      child: Text(
        '$streak-day streak',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
