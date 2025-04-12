import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/models/Streak.dart';

class StreakRepository {
  static late Isar _isar;
  
  // Initialize Isar if not already initialized
  Future<void> initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [StreakSchema],
      directory: dir.path,  
    );
  }
  
  // Get streak data (there should be only one record)
  Future<Streak?> getStreak() async {
    return await _isar.streaks.where().findFirst();
  }
  
  // Create or update streak data
  Future<void> saveStreak(Streak streak) async {
    await _isar.writeTxn(() async {
      await _isar.streaks.put(streak);
    });
  }
  
  // Update current streak
  Future<void> updateCurrentStreak(int newStreak) async {
    final streak = await getStreak();
    if (streak != null) {
      await _isar.writeTxn(() async {
        streak.currentStreak = newStreak;
        streak.lastUpdated = DateTime.now();
        
        // Update longest streak if current is greater
        if (newStreak > (streak.longestStreak ?? 0)) {
          streak.longestStreak = newStreak;
        }
        
        await _isar.streaks.put(streak);
      });
    }
  }
  
  // Reset streak to zero
  Future<void> resetStreak() async {
    final streak = await getStreak();
    if (streak != null) {
      await _isar.writeTxn(() async {
        streak.currentStreak = 0;
        streak.lastUpdated = DateTime.now();
        streak.streakStartDate = null;
        await _isar.streaks.put(streak);
      });
    }
  }
  
  // Update streak after completing all tasks for a day
  Future<void> updateStreakAfterCompletion(DateTime completionDate) async {
    Streak? streak = await getStreak();
    
    if (streak == null) {
      // First time, create new streak record
      streak = Streak(
        currentStreak: 1,
        longestStreak: 1,
        lastUpdated: DateTime.now(),
      );
      streak.lastCompletedDate = completionDate;
      streak.streakStartDate = completionDate;
    } else {
      await _isar.writeTxn(() async {
        final lastDate = streak!.lastCompletedDate;
        
        if (lastDate == null) {
          // First completion ever
          streak.currentStreak = 1;
          streak.longestStreak = 1;
          streak.streakStartDate = completionDate;
        } else {
          // Check if this is the next day (continuing streak)
          final yesterday = DateTime(completionDate.year, completionDate.month, completionDate.day - 1);
          final lastCompletionDay = DateTime(lastDate.year, lastDate.month, lastDate.day);
          
          if (yesterday.isAtSameMomentAs(lastCompletionDay)) {
            // Next consecutive day
            streak.currentStreak = (streak.currentStreak ?? 0) + 1;
            if ((streak.currentStreak ?? 0) > (streak.longestStreak ?? 0)) {
              streak.longestStreak = streak.currentStreak;
            }
          } else if (completionDate.isAfter(lastDate) && !yesterday.isAtSameMomentAs(lastCompletionDay)) {
            // Broke the streak, start new one
            streak.currentStreak = 1;
            streak.streakStartDate = completionDate;
          }
        }
        
        streak.lastCompletedDate = completionDate;
        streak.lastUpdated = DateTime.now();
        await _isar.streaks.put(streak);
      });
    }
  }
}