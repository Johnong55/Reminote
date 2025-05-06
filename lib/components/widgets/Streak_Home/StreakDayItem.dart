import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StreakDayItem extends StatelessWidget {
  final DateTime date;
  final bool isToday;
  final bool isCompleted;
  final bool isChosen;
  final Color streakColor;
  final bool isDarkMode;
  final void Function()? ontap;
  
  const StreakDayItem({
    super.key,
    required this.date,
    required this.isToday,
    required this.isCompleted,
    required this.streakColor,
    required this.isDarkMode,
    this.isChosen = false,
    required this.ontap
  });
  
  String _getDayOfWeek() {
    // Get weekday name in Vietnamese
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thus', 'Fri', 'Sat'];
    return weekdays[date.weekday % 7];
  }
  
  String _getDayOfMonth() {
    return DateFormat('dd').format(date);
  }
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
   
    final dayOfWeek = _getDayOfWeek();
    final dayOfMonth = _getDayOfMonth();
    
    // Determine which item should be highlighted
    // Default: Today is highlighted
    // After selection: Only the chosen item is highlighted
    final bool shouldHighlight = isChosen || (isToday && !isAnyItemChosen());
    
    // Determine text color based on highlight state
    Color textColor = shouldHighlight 
        ? streakColor 
        : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600);
    
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        width: 30,
        child: Column(
          children: [
            // Day of week (T2, T3, etc.)
            Text(
              isToday ? "Today" : dayOfWeek,
              style: textTheme.bodySmall?.copyWith(
                color: textColor,
                fontWeight: shouldHighlight ? FontWeight.w800 : FontWeight.w900,
                fontSize: shouldHighlight ? 10 : 9,
              ),
            ),
            const SizedBox(height: 4),
            // Square with checkmark or X
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isCompleted
                    ? streakColor
                    : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: shouldHighlight
                      ? streakColor
                      : isCompleted
                          ? streakColor
                          : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                  width: shouldHighlight ? 2 : 1,
                ),
                boxShadow: shouldHighlight ? [
                  BoxShadow(
                    color: streakColor.withOpacity(0.3),
                    blurRadius: 6,
                    spreadRadius: 1,
                  )
                ] : null,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check, size: 20, color: Colors.white)
                    : Icon(Icons.close_rounded, size: 20, color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade400),
              ),
            ),
            const SizedBox(height: 4),
            // Day of month (01, 02, etc.)
            Text(
              dayOfMonth,
              style: textTheme.bodySmall?.copyWith(
                color: textColor,
                fontWeight: shouldHighlight ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  
  bool isAnyItemChosen() {
  
    return isChosen;
  }
}