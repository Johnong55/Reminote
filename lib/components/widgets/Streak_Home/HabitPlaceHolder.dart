import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/components/commons/dialog/AddHabitDialog.dart';
import 'package:study_app/components/widgets/Streak_Home/AnimatedList.dart';

import 'package:study_app/models/Offine/Habit.dart';

import 'package:study_app/providers/Completion_provider.dart';
import 'package:study_app/providers/Streak_provider.dart';

import 'package:study_app/providers/habit_provider.dart';

class HabitsPlaceholder extends StatefulWidget {
  final DateTime chosenDate;
  const HabitsPlaceholder({super.key, required this.chosenDate});

  @override
  State<HabitsPlaceholder> createState() => _HabitsPlaceholderState();
}

class _HabitsPlaceholderState extends State<HabitsPlaceholder> {
  Future<void> onToggleComplete(Habit habit) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    if (widget.chosenDate.isBefore(startOfDay) ||
        widget.chosenDate.isAfter(endOfDay)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 247, 223, 216),
          content: const Text(
            'You cannot mark a habit as completed for a date outside today.',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final completionProvider = Provider.of<CompletionProvider>(
      context,
      listen: false,
    );
    final streakProvider = Provider.of<StreakProvider>(context, listen: false);
    
    final isCompleted = await completionProvider.isHabitCompleted(
      habit.id,
      widget.chosenDate,
    );

   await completionProvider.recordCompletions(
      habit.id,
      widget.chosenDate,
      !isCompleted,
    );
   bool dayCompleted = await  completionProvider.wereCompletedonDate();
   log("dayCompleted = $dayCompleted");
   if(dayCompleted == true){

      streakProvider.completeToday();
      streakProvider.setCompletedDay();
      
   }
  }

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your habits',
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 28,
                    color: colorScheme.primary,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddHabitDialog(
                          onSave: (habit) {
                            Provider.of<HabitProvider>(
                              context,
                              listen: false,
                            ).createHabit(habit);
                            Provider.of<CompletionProvider>(
                              context,
                              listen: false,
                            ).wereCompletedonDate();
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: AnimatedHabitList(
                habits: habitProvider.habits,
                chosenDate: widget.chosenDate,
                onToggleComplete: onToggleComplete,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
