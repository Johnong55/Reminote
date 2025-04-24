import 'package:flutter/material.dart';
import 'package:study_app/components/commons/dialog/AddHabitDialog.dart';
import 'package:study_app/components/widgets/Streak_Home/Habit_Tile.dart';
import 'package:study_app/models/Habit.dart';

class HabitsPlaceholder extends StatefulWidget {
  DateTime chosenDate;
   HabitsPlaceholder({super.key, required this.chosenDate});

  @override
  State<HabitsPlaceholder> createState() => _HabitsPlaceholderState();
}

class _HabitsPlaceholderState extends State<HabitsPlaceholder> {
  DateTime get chosenDate => widget.chosenDate;
 List<Habit> habits = [
  Habit(title: 'Read 10 pages', isCompleted: false, color: '#FFECB3'), // Amber light
  Habit(title: 'Morning Walk', isCompleted: true, color: '#C8E6C9'),   // Green light
  Habit(title: 'Meditation', isCompleted: false, color: '#BBDEFB'),   // Blue light
  Habit(title: 'Practice Coding', isCompleted: false, color: '#D1C4E9'), // Deep Purple light
  Habit(title: 'Drink Water', isCompleted: true, color: '#B2DFDB'),   // Teal light
];

  void onToggleComplete(Habit habit) {
    setState(() {
      if (habit.isCompleted != null) {
        habit.isCompleted = !habit.isCompleted!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Your habits', style: textTheme.titleLarge?.copyWith(color: colorScheme.primary)),
              IconButton(
                icon: Icon(Icons.add_circle_outline, size: 28, color: colorScheme.primary),
                onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                  return AddHabitDialog(onSave: (habit) {
                    // Handle habit save if needed
                  });
                  },
                );
                },
              ),
              ],
            ),
            ),
          const Divider(height: 1, thickness: 1, indent: 20, endIndent: 20),
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];
                return HabitTile(
                  habit: habit,
                  onToggleComplete: () => onToggleComplete(habit),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
