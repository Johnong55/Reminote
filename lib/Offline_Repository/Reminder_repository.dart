import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/models/Reminder.dart';

class ReminderRepository {
  static late Isar _isar;
  final List<Reminder> currentReminders = [];

  // Initialize Isar
  Future<void> initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [ReminderSchema],
      directory: dir.path,  
    );
  }

  // Create a new reminder
  Future<void> createReminder(Reminder newReminder) async {
    await _isar.writeTxn(() async {
      await _isar.reminders.put(newReminder);
    });
    await fetchReminders();
  }
  
  // Get all reminders
  Future<void> fetchReminders() async {
    final reminders = await _isar.reminders
      .where()
      .sortByDue_date()
      .findAll();
    currentReminders.clear();
    currentReminders.addAll(reminders);
  }

  // Update an existing reminder
  Future<void> updateReminder(Reminder reminder) async {
    await _isar.writeTxn(() async {
      await _isar.reminders.put(reminder);
    });
    await fetchReminders();
  }

  // Delete a reminder
  Future<void> deleteReminder(int id) async {
    await _isar.writeTxn(() async {
      await _isar.reminders.delete(id);
    });
    await fetchReminders();
  }

  // Delete all reminders
  Future<void> deleteAllReminders() async {
    await _isar.writeTxn(() async {
      await _isar.reminders.clear();
    });
    await fetchReminders();
  }

  // Find reminders by date
  Future<List<Reminder>> findByDay(DateTime date) async {
    // Create start and end times for the day range
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    
    return await _isar.reminders
      .filter()
      .due_dateBetween(startOfDay, endOfDay)
      .sortByDue_date()
      .findAll();
  }

  // Find reminders by completion status
  Future<List<Reminder>> findByIsCompleted(bool? isCompleted) async {
    return await _isar.reminders
      .filter()
      .isCompletedEqualTo(isCompleted)
      .sortByDue_date()
      .findAll();
  }
  
  // Get a reminder by ID
  Future<Reminder?> getReminderById(int id) async {
    return await _isar.reminders.get(id);
  }
  
  // Find reminders by date range
  Future<List<Reminder>> findByDateRange(DateTime startDate, DateTime endDate) async {
    return await _isar.reminders
      .filter()
      .due_dateBetween(startDate, endDate)
      .sortByDue_date()
      .findAll();
  }
  
  // Mark reminder as completed or incomplete
  Future<void> toggleReminderCompletion(int id, bool isCompleted) async {
    await _isar.writeTxn(() async {
      final reminder = await _isar.reminders.get(id);
      if (reminder != null) {
        reminder.isCompleted = isCompleted;
        await _isar.reminders.put(reminder);
      }
    });
    await fetchReminders();
  }
  
  // Count completed reminders by day
  Future<int> countCompletedRemindersByDay(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    
    return await _isar.reminders
      .filter()
      .due_dateBetween(startOfDay, endOfDay)
      .isCompletedEqualTo(true)
      .count();
  }
  
  // Check if all reminders for a day are completed
  Future<bool> areAllRemindersCompletedForDay(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    
    final totalReminders = await _isar.reminders
      .filter()
      .due_dateBetween(startOfDay, endOfDay)
      .count();
      
    final completedReminders = await _isar.reminders
      .filter()
      .due_dateBetween(startOfDay, endOfDay)
      .isCompletedEqualTo(true)
      .count();
      
    return totalReminders > 0 && totalReminders == completedReminders;
  }
}