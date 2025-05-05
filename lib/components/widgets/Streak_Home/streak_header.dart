import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:study_app/components/widgets/Streak_Home/MotivationalText.dart';
import 'package:study_app/components/widgets/Streak_Home/streak_animation.dart';
import 'package:study_app/config/app_theme.dart';

class StreakHeader extends StatelessWidget {
  final int currentStreak;
  final bool isCompleted;
  const StreakHeader({super.key, required this.currentStreak,required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
       StreakAnimation(isCompleted: isCompleted),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text('$currentStreak-day streak', style: textTheme.headlineMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: MotivationalText(streak: currentStreak,isCompleted: isCompleted),
        ),
      ],
    );
  }


}
