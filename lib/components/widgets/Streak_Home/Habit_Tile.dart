import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:study_app/components/commons/dialog/confirm_dialog.dart';
import 'package:study_app/models/Offine/Completions.dart';
import 'package:study_app/models/Offine/Habit.dart';
import 'package:study_app/utils/Color_helper.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback? onTap;
  final VoidCallback? onToggleComplete;
  final VoidCallback? onDelete;
  final bool? isCompletion;
  const HabitTile({
    super.key,
    required this.habit,
    this.onTap,
    this.onToggleComplete,
    required this.isCompletion,
    this.onDelete,
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

    final color_helper = Color_helper();
    final habitColor =
        habit.color != null
            ? color_helper.HexToColor(habit.color!)
            : Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot và thời gian hoàn thành
          Container(
            width: 40,
            margin: const EdgeInsets.only(top: 30, left: 8, right: 0),
            child: Column(
              children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                color: habitColor,
                shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 4),
              if (habit.due_time != null)
                ...[
                (habit.due_time!.hour == 0 && habit.due_time!.minute == 0)
                  ? Text(
                    'All day',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                    )
                  : Text(
                    DateFormat.Hm().format(habit.due_time!),
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                    ),
                ],
              ],
            ),
          ),
          // Card chính
          Expanded(
            child: Card(
              color:
                  (isCompletion ?? false)
                      ? color_helper.HexToColor(habit.color!)
                      : Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          onToggleComplete!();
                        },
                        backgroundColor:
                            habit.color != null && isCompletion == false
                                ? color_helper.HexToColor(habit.color!)
                                : Colors.grey.shade100,
                        foregroundColor: Colors.black,
                        icon:
                            (isCompletion == false)
                                ? Icons.done_outline_rounded
                                : Icons.undo,
                        label: (isCompletion == false) ? 'D O N E' : "U N D O",
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => {
                      DeleteConfirmationDialog.show(
                        context: context,
                        title: 'Xác nhận xóa',
                        content: 'Bạn có chắc chắn muốn xóa ghi chú này không?',
                        onConfirm: () {
                          if (onDelete != null) {
                            onDelete!();
                          }
                        },
                      ),
                    },
                        backgroundColor: colorScheme.error,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      habit.title ?? 'No Title',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        decoration:
                            (isCompletion ?? false)
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (habit.description != null &&
                            habit.description!.isNotEmpty)
                          Text(
                            habit.description!,
                            style: textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSurface,
                              decoration:
                                  (isCompletion ?? false)
                                      ? TextDecoration.lineThrough
                                      : null,
                            ),
                          ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.check_circle,
                      color:
                          (isCompletion ?? false)
                              ? colorScheme.tertiary
                              : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
