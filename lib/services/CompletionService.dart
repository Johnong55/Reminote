import 'package:study_app/Offline_Repository/Completions_repository.dart';
import 'package:study_app/models/Completions.dart';

class CompletionService {
  final CompletionsRepository _completionsRepository = CompletionsRepository();

  // Initialize the repository
  Future<void> initialize() async {
    await _completionsRepository.initializeIsar();
  }

  // Record a completion
  Future<void> recordCompletion(int habitId, bool isCompleted, DateTime dateCompleted) async {
    await _completionsRepository.recordCompletion(habitId, isCompleted, dateCompleted);
  }
  Future<bool> isHabitCompleted(int habitID, DateTime date) async {
    return await _completionsRepository.isHabitCompletedinDate(habitID, date);
  }
  // Get completions for a specific date
  Future<List<Completions>> getCompletionsForDate(DateTime date) async {
    return await _completionsRepository.getCompletionsForDate(date);
  }

  // Get completions for a specific habit
  Future<List<Completions>> getCompletionsForHabit(int habitId) async {
    return await _completionsRepository.getCompletionsForHabit(habitId);
  }

  // Delete a completion record
  Future<void> deleteCompletion(int id) async {
    await _completionsRepository.deleteCompletion(id);
  }

  // Get completions for a date range
  Future<List<Completions>> getCompletionsForDateRange(DateTime startDate, DateTime endDate) async {
    return await _completionsRepository.getCompletionsForDateRange(startDate, endDate);
  }
  Future<bool> wereAllCompletedOnDate(DateTime date) async {
    return await _completionsRepository.wereAllCompletedOnDate(date);
  }


}