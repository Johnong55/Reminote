import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:study_app/models/Habit.dart';
import 'package:study_app/utils/Color_helper.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback? onTap;
  final VoidCallback? onToggleComplete;

  const HabitTile({
    super.key,
    required this.habit,
    this.onTap,
    this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final dueDateStr =
        habit.due_date != null
            ? DateFormat.yMMMd().format(habit.due_date!)
            : 'No date';

    final dueTimeStr =
        habit.due_time != null ? DateFormat.Hm().format(habit.due_time!) : '';

    final isCompleted = habit.isCompleted ?? false;
    final color_helper = Color_helper();
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color:
            isCompleted ? color_helper.HexToColor(habit.color!) : Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isCompleted ? Colors.green : Colors.grey,
            ),
            onPressed: onToggleComplete,
          ),
          title: Text(
            habit.title ?? 'No Title',
            style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary)
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (habit.description != null && habit.description!.isNotEmpty)
                Text(habit.description!),
              Text(
                "Due: $dueDateStr ${dueTimeStr.isNotEmpty ? 'at $dueTimeStr' : ''}",
                style: textTheme.titleSmall?.copyWith(color: colorScheme.onSecondary),
              ),
            ],
          ),
          trailing: CircleAvatar(
            backgroundColor: _parseColor(habit.color),
            radius: 10,
          ),
        ),
      ),
    );
  }

  Color _parseColor(String? hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return Colors.grey;
    }

    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.grey;
    }
  }
}
