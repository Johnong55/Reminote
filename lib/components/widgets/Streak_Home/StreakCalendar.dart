import 'package:flutter/material.dart';
import 'package:study_app/components/widgets/Streak_Home/StreakDayItem.dart';
import 'package:intl/intl.dart';

class StreakCalendar extends StatelessWidget {
  final List<bool> completedDays;
  final int maxDaysToShow;
  final Color streakColor;
  final bool isDarkMode;
  final void Function() ontap;
  const StreakCalendar({
    super.key,
    required this.completedDays,
    required this.maxDaysToShow,
    required this.streakColor,
    required this.isDarkMode,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final today = DateTime.now();

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
              offset: const Offset(0, 2),
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
            height: 80, // Increased height for date display
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: maxDaysToShow,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                // Calculate days from today
                final middleIndex = maxDaysToShow ~/ 2; // Center position (today)
                final dayOffset = index - middleIndex; // 0 is today, -1 is yesterday, +1 is tomorrow
                final date = today.add(Duration(days: dayOffset));
                
                final isCompleted = 
                    completedDays.length > index ? completedDays[index] : false;

                // Enable scroll position to center on today
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (index == middleIndex) {
                    final scrollController = PrimaryScrollController.of(context);
                    scrollController?.animateTo(
                      middleIndex * 56.0 - (MediaQuery.of(context).size.width / 2) + 28,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                });

                return StreakDayItem(
                  date: date,
                  isToday: dayOffset == 0,
                  isCompleted: isCompleted,
                  streakColor: streakColor,
                  isDarkMode: isDarkMode,
                  ontap: ontap  ,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}