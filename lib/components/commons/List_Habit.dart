// ListStreak.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/components/widgets/Streak_Home/HabitPlaceHolder.dart';
import 'package:study_app/components/widgets/Streak_Home/StreakCalendar.dart';
import 'package:study_app/components/widgets/Streak_Home/streak_header.dart';
import 'package:study_app/providers/Completion_provider.dart';
import 'package:study_app/providers/Streak_provider.dart';
import 'package:study_app/providers/habit_provider.dart';

class ListStreak extends StatefulWidget {
  const ListStreak({super.key});

  @override
  State<ListStreak> createState() => _ListStreakState();
}

class _ListStreakState extends State<ListStreak> {
  // Example streak data (you may want to get this from a provider/controller)
  late HabitProvider habitProvider;
  late CompletionProvider completionProvider;
  late StreakProvider streakProvider;

 

  // Initially null, which means no day is selected yet and today will be highlighted
  DateTime? _chosenDate;

  @override
  void initState() {
    log("start init");
    super.initState();
    habitProvider = Provider.of<HabitProvider>(context, listen: false);
    completionProvider = Provider.of<CompletionProvider>(
      context,
      listen: false,
    ); 
    completionProvider.getAllCompletions();
    streakProvider = Provider.of<StreakProvider>(context, listen: false);
    streakProvider.initialize();
    streakProvider.currentStreakValue;
    habitProvider.intialize();
    habitProvider.fetchHabits();
   
    _chosenDate = null;
  }

  // Update chosen date when user taps on a day
  void _onDateSelected(DateTime date) {
    setState(() {
      _chosenDate = date;
      habitProvider.setCurrentDate(date);
      habitProvider.fetchHabits();
    
      log("Selected date: $_chosenDate");
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final streakColor = Colors.grey.shade200; // You can customize this color

    return Column(
      children: [
        // 🔥 Header with animation and current streak
        Consumer2<CompletionProvider, StreakProvider>(
          builder: (context, completionProvider, streakProvider, _) {
            final isCompleted = completionProvider.completed;
            final currentStreak = streakProvider.currentStreakValue;
            return StreakHeader(
              currentStreak: currentStreak,
              isCompleted: isCompleted,
            );
          },
        ),

        // 📅 Calendar showing streak history - now with Monday to Sunday
        Consumer2<CompletionProvider,StreakProvider>(
          builder: (context,provider,streakProvider,_){
            final bool isCompleted = provider.completed;
            return StreakCalendar(
              isCompletedToday: isCompleted,
            completedDays: streakProvider.completedDays,
            streakColor: streakColor,
            isDarkMode: isDarkMode,
            chosenDate: _chosenDate,
            onDateSelected: _onDateSelected,
          );
          },
         
        ),

        // ✅ Placeholder for habits of the chosen date
        Expanded(
          child: HabitsPlaceholder(
            chosenDate:
                _chosenDate ?? DateTime.now(), // Use today if no date is chosen
          ),
        ),
      ],
    );
  }
}
