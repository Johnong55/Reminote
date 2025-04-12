import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/models/Completions.dart';

class CompletionsRepository {
  static late Isar _isar;
  
  // Initialize Isar
  Future<void> initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [CompletionsSchema],
      directory: dir.path,  
    );
  }
  
  // Record a completion
  Future<void> recordCompletion(int habitId, bool allCompleted, DateTime dateCompleted) async {
    final completion = Completions()
      ..habitID = habitId
      ..allCompleted = allCompleted
      ..dateCompleted = dateCompleted;
      
    await _isar.writeTxn(() async {
      await _isar.completions.put(completion);
    });
  }
  
  // Get completions for a specific date
  Future<List<Completions>> getCompletionsForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    
    return await _isar.completions
      .filter()
      .dateCompletedBetween(startOfDay, endOfDay)
      .findAll();
  }
  
  // Check if all habits were completed on a specific date
  Future<bool> wereAllCompletedOnDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    
    final completions = await _isar.completions
      .filter()
      .dateCompletedBetween(startOfDay, endOfDay)
      .findAll();
      
    // Check if at least one completion exists and all are marked as allCompleted=true
    return completions.isNotEmpty && 
           completions.every((completion) => completion.allCompleted == true);
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
  
  // Count days with all completions in a date range (for streak calculations)
  Future<int> countDaysWithAllCompletions(DateTime startDate, DateTime endDate) async {
    final completions = await _isar.completions
      .filter()
      .dateCompletedBetween(startDate, endDate)
      .and()
      .allCompletedEqualTo(true)
      .findAll();
    
    // Group by date and count days
    final completionDays = <DateTime>{};
    for (var completion in completions) {
      if (completion.dateCompleted != null) {
        final day = DateTime(
          completion.dateCompleted!.year,
          completion.dateCompleted!.month,
          completion.dateCompleted!.day,
        );
        completionDays.add(day);
      }
    }
    
    return completionDays.length;
  }
}