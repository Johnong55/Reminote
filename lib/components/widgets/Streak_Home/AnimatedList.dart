// animated_habit_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/models/Offine/Habit.dart';
import 'package:study_app/components/widgets/Streak_Home/Habit_Tile.dart';
import 'package:study_app/providers/Completion_provider.dart';

class AnimatedHabitList extends StatefulWidget {
  final List<Habit> habits;
  final DateTime chosenDate;
  final void Function(Habit habit) onToggleComplete;

  const AnimatedHabitList({
    super.key,
    required this.habits,
    required this.onToggleComplete,
    required this.chosenDate,
  });

  @override
  State<AnimatedHabitList> createState() => _AnimatedHabitListState();
}

class _AnimatedHabitListState extends State<AnimatedHabitList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Habit> _displayedHabits = [];

  @override
  void initState() {
    super.initState();
    _displayedHabits = List.from(widget.habits);
  }

  @override
  void didUpdateWidget(covariant AnimatedHabitList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.habits != widget.habits) {
      _updateListWithAnimation(widget.habits);
    }
  }

  void _updateListWithAnimation(List<Habit> newHabits) {
    for (int i = _displayedHabits.length - 1; i >= 0; i--) {
      final habit = _displayedHabits[i];
      if (!newHabits.any((h) => h.id == habit.id)) {
        final removed = _displayedHabits.removeAt(i);
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => _buildRemovedItem(removed, animation),
        );
      }
    }

    for (int i = 0; i < newHabits.length; i++) {
      final habit = newHabits[i];
      if (!_displayedHabits.any((h) => h.id == habit.id)) {
        _displayedHabits.insert(i, habit);
        _listKey.currentState?.insertItem(i);
      }
    }
  }

  Widget _buildRemovedItem(Habit habit, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
          child: Consumer<CompletionProvider>(
          builder: (context, provider, _) {
            final isCompletionFuture = provider.isHabitCompleted(habit.id, widget.chosenDate);
            return FutureBuilder<bool>(
              future: isCompletionFuture,
              builder: (context, snapshot) {
                final isCompletion = snapshot.data ?? false;
                return HabitTile(
                  habit: habit,
                  isCompletion: isCompletion,
                  onToggleComplete: () => widget.onToggleComplete(habit),
                );
              },
            );
          }
        ),
      ),
    );
  }

  Widget _buildAnimatedItem(Habit habit, Animation<double> animation)  {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child:  Consumer<CompletionProvider>(
          builder: (context, provider, _) {
            final isCompletionFuture = provider.isHabitCompleted(habit.id, widget.chosenDate);
            return FutureBuilder<bool>(
              future: isCompletionFuture,
              builder: (context, snapshot) {
                final isCompletion = snapshot.data ?? false;
                return HabitTile(
                  habit: habit,
                  isCompletion: isCompletion,
                  onToggleComplete: () => widget.onToggleComplete(habit),
                );
              },
            );
          }
      ),
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _displayedHabits.length,
      itemBuilder: (context, index, animation) {
        return _buildAnimatedItem(_displayedHabits[index], animation);
      },
    );
  }
}
