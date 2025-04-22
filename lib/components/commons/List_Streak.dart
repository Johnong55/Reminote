import 'package:flutter/material.dart';
import 'package:study_app/components/widgets/Streak_Home/HabitPlaceHolder.dart';
import 'package:study_app/components/widgets/Streak_Home/StreakCalendar.dart';
import 'package:study_app/components/widgets/Streak_Home/streak_header.dart';

class ListStreak extends StatelessWidget {
  ListStreak({super.key});

  // Example streak data (you may want to get this from a provider/controller)
  final int currentStreak = 5;
  final int maxDaysToShow = 7;
  final List<bool> completedDays = [true, true, true, true, true, false, false];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final streakColor = Colors.orange; // You can customize this color
    
    return Column(
      children: [
        // 🔥 Header with animation and current streak
        StreakHeader(currentStreak: currentStreak),

        // 📅 Calendar showing streak history
        StreakCalendar(
          maxDaysToShow: maxDaysToShow,
          completedDays: completedDays,
          streakColor: streakColor,
          isDarkMode: isDarkMode,
        ),

        // ✅ Placeholder for today's habits (can be replaced with real data later)
        const Expanded(child: HabitsPlaceholder()),
      ],
    );
  }
}
