import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/Offline_Repository/Completions_repository.dart';
import 'package:study_app/models/Habit.dart';

class HabitRepository {
  static late Isar _isar;
  final CompletionsRepository _completionsRepository = CompletionsRepository();
  final List<Habit> currenthabits = [];

  // Initialize Isar
  Future<void> initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([HabitSchema], directory: dir.path);
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
    final DateOnly = DateTime(date.year, date.month, date.day);
    final specificHabits =
        await _isar.habits.filter().due_dateEqualTo(date).findAll();
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

  Future<List<Habit>> getListDailyHabits(DateTime date) async {
    final dailyHabit =
        await _isar.habits
            .filter()
            .due_dateLessThan(date)
            .and()
            .frequency_typeEqualTo(1) // dayly
            .findAll();
    return [...dailyHabit];
  }

  Future<List<Habit>> getListWeeklyHabit(DateTime date) async {
    final allWeeklyHabits =
        await _isar.habits
            .filter()
            .frequency_typeEqualTo(2) // weekly
            .and()
            .due_dateLessThan(date)
            .findAll();
    final weeklyHabits =
        allWeeklyHabits.where((habit) {
          final due = DateTime(
            habit.due_date!.year,
            habit.due_date!.month,
            habit.due_date!.day,
          );
          final diffDays = date.difference(due).inDays;
          return diffDays % 7 ==
              0; // Assuming weekly habits repeat every 7 days
        }).toList();
    return weeklyHabits;
  }

  Future<List<Habit>> getListMonthlyHabits(DateTime date) async {
    final allMonthLyHabit =
        await _isar.habits
            .filter()
            .due_dateLessThan(date)
            .and()
            .frequency_typeEqualTo(3)
            .findAll();
    final monthlyHabits =
        allMonthLyHabit.where((habit) {
          final due = habit.due_date!.day;
          return due == date.day;
        }).toList();
    return monthlyHabits;
  }
}
