import 'package:study_app/Offline_Repository/Habit_repository.dart';
import 'package:study_app/models/Habit.dart';


class HabitService {
  final HabitRepository _habitRepository;

  HabitService(this._habitRepository);

  // Initialize the database
  Future<void> init() async {
    await _habitRepository.initializeIsar();
  }

  // Create a habit
  Future<void> addHabit(Habit habit) async {
    await _habitRepository.createHabit(habit);
  }

  // Get all habits
  List<Habit> get allHabits => _habitRepository.currenthabits;

  // Fetch all habits from DB
  Future<void> refreshHabits() async {
    await _habitRepository.fetchhabits();
  }

  // Get a habit by ID
  Future<Habit?> getHabitById(int id) async {
    return await _habitRepository.getHabitById(id);
  }

  // Update an existing habit
  Future<void> updateHabit(Habit habit) async {
    await _habitRepository.updateHabit(habit);
  }

  // Delete a habit by ID
  Future<void> deleteHabit(int id) async {
    await _habitRepository.deleteHabit(id);
  }

  // Delete all habits
  Future<void> clearAllHabits() async {
    await _habitRepository.deleteAllhabits();
  }

  // Toggle a habit's completion state
  Future<void> toggleCompletion(int id, bool isCompleted) async {
    await _habitRepository.toggleHabitCompletion(id, isCompleted);
  }

  // Get habits for a specific day (including repeating ones)
  Future<List<Habit>> getHabitsForDay(DateTime date) async {
    return await _habitRepository.getListHabitInSpecDay(date);
  }

  // Get only daily habits
  Future<List<Habit>> getDailyHabits(DateTime date) async {
    return await _habitRepository.getListDailyHabits(date);
  }

  // Get only weekly habits
  Future<List<Habit>> getWeeklyHabits(DateTime date) async {
    return await _habitRepository.getListWeeklyHabit(date);
  }

  // Get only monthly habits
  Future<List<Habit>> getMonthlyHabits(DateTime date) async {
    return await _habitRepository.getListMonthlyHabits(date);
  }

  // Get habits filtered by completion
  Future<List<Habit>> getHabitsByCompletion(bool isCompleted) async {
    return await _habitRepository.findByIsCompleted(isCompleted);
  }

  // Get habits in a date range
  Future<List<Habit>> getHabitsByDateRange(DateTime start, DateTime end) async {
    return await _habitRepository.findByDateRange(start, end);
  }

  // Count completed habits for a specific day
  Future<int> countCompletedForDay(DateTime date) async {
    return await _habitRepository.countCompletedhabitsByDay(date);
  }

  // Check if all habits for a day are completed
  Future<bool> areAllHabitsCompleted(DateTime date) async {
    return await _habitRepository.areAllhabitsCompletedForDay(date);
  }
}
