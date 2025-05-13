import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/utils/Isar_Util.dart';
import 'package:study_app/models/Offine/Completions.dart';
import 'package:study_app/models/Offine/Habit.dart';
import 'package:study_app/Offline_Repository/Habit_repository.dart';

class CompletionsRepository {
  static late Isar _isar;
  static final habitRepository = HabitRepository();

  // Initialize Isar database
  Future<void> initializeIsar() async {
    _isar = await IsarUtil.getIsarInstance();
  }

  // Record or update a completion
  Future<Completions> recordCompletion(
    int habitId,
    DateTime dateCompleted, {
    bool isCompleted = true,
    bool needSync = true,
    String ID= "" ,
  }) async {
    final normalizedDate = DateTime(
      dateCompleted.year,
      dateCompleted.month,
      dateCompleted.day,
    );

    // Check if a completion already exists for this habit on this date
    final existing =
        await _isar.completions
            .filter()
            .habitIDEqualTo(habitId)
            .dateCompletedEqualTo(normalizedDate)
            .findFirst();

    if (existing != null) {
      // Update existing completion
      existing.isCompleted = isCompleted;
      existing.lastModified = DateTime.now();
      

      await _isar.writeTxn(() async {
        await _isar.completions.put(existing);
      });

      log("Updated existing completion: $existing");
       log("================================================");
 
      return existing;
    } else {
      // Create new completion
      final completion =
          Completions()
            ..habitID = habitId
            ..isCompleted = isCompleted
            ..dateCompleted = normalizedDate
            ..ID = ID ?? "local_${DateTime.now().millisecondsSinceEpoch}"
            ..userEmail = "local_user"
            ..lastModified = DateTime.now()
            ..needsSync = needSync;

      await _isar.writeTxn(() async {
        await _isar.completions.put(completion);
      });

      log("Inserted new completion: $completion");

      return completion;
    }
   
  }

  // Update a completion with sync status
  Future<void> updateCompletion(Completions completion) async {
    await _isar.writeTxn(() async {
      completion.lastModified = DateTime.now();
      await _isar.completions.put(completion);
    });
  }

  // Mark a completion as synced
  Future<void> markAsSynced(Completions completion) async {
    await _isar.writeTxn(() async {
      completion.needsSync = false;
      await _isar.completions.put(completion);
    });
  }

  // Get all completions that need to be synced
  Future<List<Completions>> getUnsynced() async {
    return await _isar.completions.filter().needsSyncEqualTo(true).findAll();
  }

  // Get completions for a specific date
  Future<List<Completions>> getCompletionsForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return await _isar.completions
        .filter()
        .dateCompletedBetween(startOfDay, endOfDay)
        .and()
        .isCompletedEqualTo(true)
        .findAll();
  }

  // Check if all habits were completed on a specific date
  Future<bool> wereAllCompletedOnDate(DateTime date) async {
    List<Completions> completions = await getCompletionsForDate(date);
    List<Habit> habits = await habitRepository.getListHabitInSpecDay(date);

    return habits.isNotEmpty && completions.length == habits.length;
  }

  // Get completions for a specific habit
  Future<List<Completions>> getCompletionsForHabit(int habitId) async {
    return await _isar.completions.filter().habitIDEqualTo(habitId).findAll();
  }

  // Delete completion by ID
  Future<void> deleteCompletion(int id) async {
    await _isar.writeTxn(() async {
      await _isar.completions.delete(id);
    });
  }

  // Get completion records for a date range
  Future<List<Completions>> getCompletionsForDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final normalizedStartDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    final normalizedEndDate = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      23,
      59,
      59,
    );

    return await _isar.completions
        .filter()
        .dateCompletedBetween(normalizedStartDate, normalizedEndDate)
        .findAll();
  }

  // Check if a specific habit is completed on a specific date
  Future<bool> isHabitCompletedOnDate(int habitID, DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    final completion =
        await _isar.completions
            .filter()
            .habitIDEqualTo(habitID)
            .dateCompletedEqualTo(normalizedDate)
            .isCompletedEqualTo(true)
            .findFirst();

    return completion != null;
  }

  // Get all completions (for full sync)
  Future<List<Completions>> getAllCompletions() async {
    return await _isar.completions.where().findAll();
  }

  // Get completion by Firebase document ID
  Future<Completions?> getCompletionByFirebaseId(String firebaseId) async {
    return await _isar.completions.filter().iDEqualTo(firebaseId).findFirst();
  }

  // Get completion by habit ID and date
  Future<Completions?> getCompletionByHabitAndDate(
    int habitId,
    DateTime date,
  ) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);

    return await _isar.completions
        .filter()
        .habitIDEqualTo(habitId)
        .dateCompletedEqualTo(normalizedDate)
        .findFirst();
  }

  // Delete all completions
  Future<void> deleteAllCompletions() async {
    await _isar.writeTxn(() async {
      await _isar.completions.clear();
    });
  }

  // Update Firebase ID for a local completion
  Future<void> updateFirebaseId(int localId, String firebaseId) async {
    await _isar.writeTxn(() async {
      final completion = await _isar.completions.get(localId);
      if (completion != null) {
        completion.ID = firebaseId;
        completion.needsSync = false;
        await _isar.completions.put(completion);
      }
    });
  }
}
