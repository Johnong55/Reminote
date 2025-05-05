import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/Offline_Repository/Habit_repository.dart';
import 'package:study_app/models/Completions.dart';
import 'package:study_app/models/Habit.dart';
import 'package:study_app/utils/Isar_Util.dart';

class CompletionsRepository {
  static late Isar _isar;
  static final habitRepository = HabitRepository();
  // Initialize Isar
  Future<void> initializeIsar() async {
    _isar = await IsarUtil.getIsarInstance();
  }
  
Future<void> recordCompletion(int habitId, DateTime dateCompleted) async {
  final normalizedDate = DateTime(dateCompleted.year, dateCompleted.month, dateCompleted.day);

  final existing = await _isar.completions
      .filter()
      .habitIDEqualTo(habitId)
      .dateCompletedEqualTo(normalizedDate)
      .findFirst();

  if (existing != null) {
    // 🔁 Đã tồn tại → cập nhật
    existing.isCompleted = !existing.isCompleted!;

    await _isar.writeTxn(() async {
      await _isar.completions.put(existing);
    });
    log("Updated existing completion: $existing");
  } else {
    // ➕ Chưa có → thêm mới
    final completion = Completions()
      ..habitID = habitId
      ..isCompleted = true
      ..dateCompleted = normalizedDate;

    await _isar.writeTxn(() async {
      await _isar.completions.put(completion);
    });
    log("Inserted new completion: $completion");
  }
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
    log("wereAllCompletedOnDate: $date");

    List<Completions> completions = await getCompletionsForDate(date);
    List<Habit> habits = await  habitRepository.getListHabitInSpecDay(date) ; 

    log("completions : ${completions.length}, habit: ${habits.length}");// Assuming this method exists in HabitRepository
    return habits.isNotEmpty && completions.length == habits.length; // Check if all habits are completed
  
    // Check if at least one completion exists and all are marked as allCompleted=true
  }
  
  // Get completions for a specific habit
  Future<List<Completions>> getCompletionsForHabit(int habitId) async {
    return await _isar.completions
      .filter()
      .habitIDEqualTo(habitId)
      .findAll();
  }
  
  // Delete completion records
  Future<void> deleteCompletion(int id) async {
    await _isar.writeTxn(() async {
      await _isar.completions.delete(id);
    });
  }
  
  // Get completion records for a date range
  Future<List<Completions>> getCompletionsForDateRange(DateTime startDate, DateTime endDate) async {
    return await _isar.completions
      .filter()
      .dateCompletedBetween(startDate, endDate)
      .findAll();
  }
  Future<bool> isHabitCompletedinDate(int habitID, DateTime date) async {
    List<Completions> completions = await getCompletionsForDate(date);
    for (var completion in completions) {
      if (completion.habitID == habitID) {
        return completion.isCompleted ?? false;
      }
    }
    return false;
  }
  
}