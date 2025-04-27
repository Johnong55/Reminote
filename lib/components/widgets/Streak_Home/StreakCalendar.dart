// StreakCalendar.dart
import 'package:flutter/material.dart';
import 'package:study_app/components/widgets/Streak_Home/StreakDayItem.dart';
import 'package:intl/intl.dart';

class StreakCalendar extends StatelessWidget {
  final List<bool> completedDays;
  final Color streakColor;
  final bool isDarkMode;
  final DateTime? chosenDate; // Can be null if no date is chosen yet
  final void Function(DateTime) onDateSelected;
  
  const StreakCalendar({
    super.key,
    required this.completedDays,
    required this.streakColor,
    required this.isDarkMode,
    required this.chosenDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    // Get the date of Monday of the current week
    final today = DateTime.now();
    final mondayOfWeek = _getMondayOfWeek(today);

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
              itemCount: 12, // Monday to Sunday (7 days)
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                // Calculate date from Monday to Sunday
                final date = mondayOfWeek.add(Duration(days: index));
                
                // Check if day is completed based on index
                final isCompleted = 
                    completedDays.length > index ? completedDays[index] : false;
                
                // Check if this is the chosen date
                final isChosen = chosenDate != null && _isSameDay(date, chosenDate!);
                
                // Check if this is today
                final isToday = _isSameDay(date, today);

                return StreakDayItem(
                  date: date,
                  isToday: isToday,
                  isChosen: isChosen,
                  isCompleted: isCompleted,
                  streakColor: streakColor,
                  isDarkMode: isDarkMode,
                  ontap: () => onDateSelected(date),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper to get Monday of the current week
  DateTime _getMondayOfWeek(DateTime date) {
    // Weekday is 1-based where 1 is Monday and 7 is Sunday
    int difference = date.weekday - 1;
    return date.subtract(Duration(days: difference));
  }
  
  // Helper to check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && 
           date1.month == date2.month && 
           date1.day == date2.day;
  }
}
