import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StreakDayItem extends StatelessWidget {
  final int daysAgo;
  final bool isCompleted;
  final Color streakColor;
  final bool isDarkMode;

  const StreakDayItem({
    super.key,
    required this.daysAgo,
    required this.isCompleted,
    required this.streakColor,
    required this.isDarkMode,
  });

  String _getLabel(int daysAgo) {
    if (daysAgo == 0) return 'N';
    if (daysAgo == 1) return 'Y';
    final date = DateTime.now().subtract(Duration(days: daysAgo));
    const days = ['', 'M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return days[date.weekday];
  }

  @override
  Widget build(BuildContext context) {
    final label = _getLabel(daysAgo);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        log('Tapped on day $daysAgo (${isCompleted ? "completed" : "missed"})');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        width: 48,
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted
                    ? streakColor
                    : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isCompleted
                      ? streakColor
                      : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                ),
              ),
              child: Center(
                child: isCompleted
                    ? Icon(Icons.check, size: 20, color: Colors.white)
                    : Icon(Icons.close_rounded, size: 20, color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade400),
              ),
            ),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: isCompleted ? Colors.white : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}
