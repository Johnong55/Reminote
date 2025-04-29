import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/Offline_Repository/Completions_repository.dart';
import 'package:study_app/models/Habit.dart';
import 'package:study_app/utils/Isar_Util.dart';

class HabitRepository {
  static late Isar _isar;
  final CompletionsRepository _completionsRepository = CompletionsRepository();
  final List<Habit> currenthabits = [];

  // Initialize Isar
  Future<void> initializeIsar() async {
    _isar = await IsarUtil.getIsarInstance();
  }

  // Create a new Habit
  Future<void> createHabit(Habit newHabit) async {
    await _isar.writeTxn(() async {
      await _isar.habits.put(newHabit);
    });
    await fetchhabits();
  }

  // Get all habits
  Future<void> fetchhabits() async {
    final habits = await _isar.habits.where().sortByDue_date().findAll();
    currenthabits.clear();
    currenthabits.addAll(habits);
  }

  // Update an existing Habit
  Future<void> updateHabit(Habit Habit) async {
    await _isar.writeTxn(() async {
      await _isar.habits.put(Habit);
    });
    await fetchhabits();
  }

  // Delete a Habit
  Future<void> deleteHabit(int id) async {
    await _isar.writeTxn(() async {
      await _isar.habits.delete(id);
    });
    await fetchhabits();
  }

  // Delete all habits
  Future<void> deleteAllhabits() async {
    await _isar.writeTxn(() async {
      await _isar.habits.clear();
    });
    await fetchhabits();
  }

  // Find habits by date
  Future<List<Habit>> findByDay(DateTime date) async {
    // Create start and end times for the day range
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return await _isar.habits
        .filter()
        .due_dateBetween(startOfDay, endOfDay)
        .sortByDue_date()
        .findAll();
  }

  // Find habits by completion status
  Future<List<Habit>> findByIsCompleted(bool? isCompleted) async {
    return await _isar.habits
        .filter()
        .isCompletedEqualTo(isCompleted)
        .sortByDue_date()
        .findAll();
  }

  // Get a Habit by ID
  Future<Habit?> getHabitById(int id) async {
    return await _isar.habits.get(id);
  }

  // Find habits by date range
  Future<List<Habit>> findByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _isar.habits
        .filter()
        .due_dateBetween(startDate, endDate)
        .sortByDue_date()
        .findAll();
  }

  // Mark Habit as completed or incomplete
  Future<void> toggleHabitCompletion(int id, bool isCompleted) async {
    await _isar.writeTxn(() async {
      final Habit = await _isar.habits.get(id);
      if (Habit != null) {
        Habit.isCompleted = isCompleted;
        await _isar.habits.put(Habit);
      }
    });
    await fetchhabits();
  }

  // Count completed habits by day
  Future<int> countCompletedhabitsByDay(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return await _isar.habits
        .filter()
        .due_dateBetween(startOfDay, endOfDay)
        .isCompletedEqualTo(true)
        .count();
  }

  // Check if all habits for a day are completed
  Future<bool> areAllhabitsCompletedForDay(DateTime date) async {
    final List<Habit> ListHabits = await getListHabitInSpecDay(date);
    final completiton = await _completionsRepository.getCompletionsForDate(
      date,
    );
    if (completiton.length == ListHabits.length && ListHabits.length > 0) {
      return true;
    }
    return false;
  }

  Future<List<Habit>> getListHabitInSpecDay(DateTime date) async {
    final specificHabits = await getListOnceTimeHabits(date);

    final dailyHabits = await getListDailyHabits(date);
    final weeklyHabits = await getListWeeklyHabit(date);
    final monthlyHabits = await getListMonthlyHabits(date);

    return [
      ...specificHabits,
      ...dailyHabits,
      ...weeklyHabits,
      ...monthlyHabits,
    ];
  }

  Future<List<Habit>> getListOnceTimeHabits(DateTime date) async {
    final onceHabit =
      await _isar.habits
        .filter()
        .frequency_typeEqualTo(0) // once-time
        .and()
        .start_dateBetween(
          DateTime(date.year, date.month, date.day).millisecondsSinceEpoch,
          DateTime(date.year, date.month, date.day, 23, 59, 59).millisecondsSinceEpoch,
        )
        .findAll();
    return [...onceHabit];
  }

  Future<List<Habit>> getListDailyHabits(DateTime date) async {
    
      final dateinmilli = date.millisecondsSinceEpoch;
    log("date: ${date.microsecondsSinceEpoch}");
  
    final dailyHabit =
        await _isar.habits
            .filter()
            .start_dateLessThan(dateinmilli)
            .and()
            .frequency_typeEqualTo(1)
            .and() // dayly
            .due_dateGreaterThan(date)
            .sortByDue_time()
            .findAll();
    
    return [...dailyHabit];
  }

  Future<List<Habit>> getListWeeklyHabit(DateTime date) async {
    DateTime currentDate = DateTime(date.year, date.month, date.day,0,0,0); 
    final allWeeklyHabits =
        await _isar.habits
            .filter()
            .frequency_typeEqualTo(2)
            .and() // weekly
            .due_dateGreaterThan(date)
            .sortByDue_time()
            .findAll();

    final weeklyHabits =
        allWeeklyHabits.where((habit) {
          // Convert milliseconds since epoch to DateTime
          final startDateTime = DateTime.fromMillisecondsSinceEpoch(
            habit.start_date!,
          );

          // Calculate days difference from start date to current date
          final diffDays = currentDate.difference(startDateTime).inDays;

          // Check if today is a day when the habit should occur (every 7 days from start)
          return diffDays >= 0 && diffDays % 7 == 0;
        }).toList();

    return weeklyHabits;
  }

  Future<List<Habit>> getListMonthlyHabits(DateTime date) async {
    final allMonthlyHabit =
        await _isar.habits
            .filter()
            .frequency_typeEqualTo(3) // monthly
            .and() // weekly
            .due_dateGreaterThan(date)
            .sortByDue_time()
            .findAll();

    final monthlyHabits =
        allMonthlyHabit.where((habit) {
          // Convert milliseconds since epoch to DateTime
          final startDateTime = DateTime.fromMillisecondsSinceEpoch(
            habit.start_date!,
          );

          // Check if the day of month matches
          return startDateTime.day == date.day;
        }).toList();

    return monthlyHabits;
  }
}
