import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'package:study_app/models/Offine/Streak.dart';
import 'package:study_app/utils/Isar_Util.dart';

class StreakRepository {
  static late Isar _isar;

  // Initialize Isar if not already initialized
  Future<void> initializeIsar() async {
    _isar = await IsarUtil.getIsarInstance();
  }

  Future<List<Streak>> getAllStreak() async {
    return await _isar.streaks.where().sortByLastCompletedDateDesc().findAll();
  }

  Future<Streak?> getLastestStreak() async {
    Streak? streak =
        await _isar.streaks.where().sortByLastCompletedDateDesc().findFirst();

    if (streak?.lastCompletedDate == null) {
      return null;
    } else {
      if (isConsecutiveDay(streak!.lastCompletedDate, DateTime.now()) || isSameDay(streak!.lastCompletedDate,DateTime.now()) ) {
   
        return streak;
      }
    }
    return null;
  }


  // Create or update streak data
  Future<void> saveStreak(Streak streak) async {
    await _isar.writeTxn(() async {
      await _isar.streaks.put(streak);
    });
  }
  Future<Streak> updateStreakAfterCompletion() async {
    
    final DateTime completionDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    // Get existing streak
    Streak? streak = await getLastestStreak();
  
    if (streak == null) {

      // First time, create new streak record
      streak = Streak(
        currentStreak: 1,
        lastUpdated: DateTime.now(),
        lastCompletedDate: completionDay,
        streakStartDate: completionDay,
      );

      await saveStreak(streak);
      return streak;
    }

    // Update existing streak
    await _isar.writeTxn(() async {
      final DateTime lastCompletionDay =
          streak!.lastCompletedDate != null
              ? DateTime(
                streak.lastCompletedDate!.year,
                streak.lastCompletedDate!.month,
                streak.lastCompletedDate!.day,
              )
              : DateTime(1970);

      // If already completed today, don't increment the streak
      if (isSameDay(completionDay, lastCompletionDay)) {
        // Just update the lastUpdated time
        streak.lastUpdated = DateTime.now();
      }
      // If this is the next consecutive day (yesterday was the last completion)
      else if (isConsecutiveDay(completionDay, lastCompletionDay)) {
        // Increment streak counter
 
        streak.currentStreak = (streak.currentStreak ?? 0) + 1;
        streak.lastCompletedDate = completionDay;
        streak.lastUpdated = DateTime.now();
      }
      // If it's been more than one day since the last completion
      else if (completionDay.isAfter(lastCompletionDay)) {
        // Start a new streak
        streak.currentStreak = 1;
        streak.streakStartDate = completionDay;
        streak.lastCompletedDate = completionDay;
        streak.lastUpdated = DateTime.now();
      }

      await _isar.streaks.put(streak);
    });

    return streak;
  }

  Future<Streak> updateStreakAfterUnCompletion() async {
    final DateTime completionDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    // Get existing streak
    Streak? streak = await getLastestStreak();

    if (streak == null) {
      // First time, create new streak record

      streak = Streak(
        currentStreak: 0,
        lastUpdated: DateTime.now(),
        lastCompletedDate: completionDay,
        streakStartDate: completionDay,
      );
      return streak;
   
    }

    // Update existing streak
    await _isar.writeTxn(() async {
      final DateTime lastCompletionDay =
          streak!.lastCompletedDate != null
              ? DateTime(
                streak.lastCompletedDate!.year,
                streak.lastCompletedDate!.month,
                streak.lastCompletedDate!.day,
              )
              : DateTime(1970);

      // If already completed today, don't increment the streak
      if (isSameDay(completionDay, lastCompletionDay)) {
        // Just update the lastUpdated timestamp
        streak.lastUpdated = DateTime.now();
        streak.currentStreak = (streak.currentStreak ?? 0) - 1;
        streak.lastCompletedDate =  DateTime.now().subtract(Duration(days: 1));
      }
      // If this is the next consecutive day (yesterday was the last completion)
   
      await _isar.streaks.put(streak);
    });


    return streak;
  }

  /// Check if streak is active (completed yesterday or today)
  Future<bool> isStreakActive() async {
    final streak = await getLastestStreak();
    if (streak == null || streak.lastCompletedDate == null) return false;

    final DateTime today = DateTime.now();
    final DateTime todayDate = DateTime(today.year, today.month, today.day);
    final DateTime lastCompletionDay = DateTime(
      streak.lastCompletedDate!.year,
      streak.lastCompletedDate!.month,
      streak.lastCompletedDate!.day,
    );

    // Streak is active if completed today or yesterday
    return isSameDay(todayDate, lastCompletionDay) ||
        isConsecutiveDay(todayDate, lastCompletionDay);
  }

  /// Helper method to check if two dates are the same day
  bool isSameDay(DateTime? date1, DateTime date2) {
    return date1!.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Helper method to check if date1 is exactly one day after date2
  bool isConsecutiveDay(DateTime? date1, DateTime date2) {
    // Create dates with only day information
    final DateTime d1 = DateTime(date1!.year, date1.month, date1.day);
    final DateTime d2 = DateTime(date2.year, date2.month, date2.day);
   
    // Get the difference in days
    final difference = d1.difference(d2).inDays;

    // Return true if date1 is exactly one day after date2
    return difference == 1 || difference == -1;
  }
  Future<void> deleteStreak(Streak streak) async {
    await _isar.writeTxn(() async {
      await _isar.streaks.delete(streak.id);
    });
  }
  Future<void> deleteAllStreak() async {
    await _isar.writeTxn(() async {
      await _isar.streaks.clear();
    });
  }
}
