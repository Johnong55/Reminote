import 'package:flutter/material.dart';
import 'package:study_app/components/widgets/Streak_Home/StreakDayItem.dart';

class StreakCalendar extends StatelessWidget {
  final List<bool> completedDays;
  final int maxDaysToShow;
  final Color streakColor;
  final bool isDarkMode;

  const StreakCalendar({
    super.key,
    required this.completedDays,
    required this.maxDaysToShow,
    required this.streakColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Your streak history', style: textTheme.titleMedium),
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: maxDaysToShow,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                final daysAgo = maxDaysToShow - index - 1;
                final isCompleted = index < completedDays.length ? completedDays[index] : false;

                return StreakDayItem(
                  daysAgo: daysAgo,
                  isCompleted: isCompleted,
                  streakColor: streakColor,
                  isDarkMode: isDarkMode,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
