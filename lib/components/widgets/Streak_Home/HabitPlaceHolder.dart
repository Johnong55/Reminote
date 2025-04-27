import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/components/commons/dialog/AddHabitDialog.dart';
import 'package:study_app/components/widgets/Streak_Home/Habit_Tile.dart';
import 'package:study_app/models/Habit.dart';
import 'package:study_app/providers/habit_provider.dart';

class HabitsPlaceholder extends StatefulWidget {
  DateTime chosenDate;
  HabitsPlaceholder({super.key, required this.chosenDate});

  @override
  State<HabitsPlaceholder> createState() => _HabitsPlaceholderState();
}

class _HabitsPlaceholderState extends State<HabitsPlaceholder> {
  // Key for the AnimatedList
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  
  // Local list to keep track of habits for animation purposes
  List<Habit> _habits = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch habits from provider
      final habitProvider = Provider.of<HabitProvider>(context, listen: false);
      habitProvider.fetchHabits();
      
      // Initialize local list with current habits
      setState(() {
        _habits = List.from(habitProvider.habits);
      });
    });
  }

  // Listen for changes in the provider's habit list
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final habitProvider = Provider.of<HabitProvider>(context);
    
    // If provider habits and local habits are different, update with animations
    if (_habits.length != habitProvider.habits.length) {
      _updateListWithAnimation(habitProvider.habits);
    }
  }

  // Update the list with animations
  void _updateListWithAnimation(List<Habit> newHabits) {
    // Handle removals
    for (int i = _habits.length - 1; i >= 0; i--) {
      final habit = _habits[i];
      if (!newHabits.any((h) => h.id == habit.id)) {
        final removedItem = _habits.removeAt(i);
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => _buildRemovedItem(removedItem, context, animation),
          duration: const Duration(milliseconds: 300),
        );
      }
    }

    // Handle additions
    for (int i = 0; i < newHabits.length; i++) {
      final newHabit = newHabits[i];
      if (!_habits.any((h) => h.id == newHabit.id)) {
        if (i <= _habits.length) {
          _habits.insert(i, newHabit);
          _listKey.currentState?.insertItem(i, duration: const Duration(milliseconds: 300));
        } else {
          _habits.add(newHabit);
          _listKey.currentState?.insertItem(_habits.length - 1, duration: const Duration(milliseconds: 300));
        }
      }
    }
  }

  // Widget for items being removed from the list
  Widget _buildRemovedItem(Habit habit, BuildContext context, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: HabitTile(
          habit: habit,
          onToggleComplete: () {},
        ),
      ),
    );
  }

  void onToggleComplete(Habit habit) {
    if (habit.isCompleted != null) {
      habit.isCompleted = !habit.isCompleted!;
      // Update the provider and database
      Provider.of<HabitProvider>(context, listen: false).updateHabit(habit);
    }
  }

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context, listen: true);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Update local list if needed (without animations in build method - animations handled in didChangeDependencies)
    if (_habits.length != habitProvider.habits.length) {
      _habits = List.from(habitProvider.habits);
    }

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
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: _habits.length,
                  itemBuilder: (context, index, animation) {
                    return _buildAnimatedItem(_habits[index], context, animation);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build animated item for the list
  Widget _buildAnimatedItem(Habit habit, BuildContext context, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      )),
      child: FadeTransition(
        opacity: animation,
        child: HabitTile(
          habit: habit,
          onToggleComplete: () => onToggleComplete(habit),
        ),
      ),
    );
  }
}