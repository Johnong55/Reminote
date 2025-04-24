import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StreakDayItem extends StatelessWidget {
  final DateTime date;
  final bool isToday;
  final bool isCompleted;
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
    required this.ontap
  });

  String _getDayOfWeek() {
    // Get weekday name in Vietnamese
    final weekdays = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
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

    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        width: 48,
        child: Column(
          children: [
            // Day of week (T2, T3, etc.)
            Text(
              dayOfWeek,
              style: textTheme.bodySmall?.copyWith(
                color: isToday 
                    ? streakColor
                    : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            // Circle with checkmark or X
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted
                    ? streakColor
                    : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isToday 
                      ? streakColor 
                      : isCompleted
                          ? streakColor
                          : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                  width: isToday ? 2 : 1,
                ),
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
                color: isToday 
                    ? streakColor
                    : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}