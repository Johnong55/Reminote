
import 'package:isar/isar.dart';

part 'Streak.g.dart';

@Collection()
class Streak{
  Id id = Isar.autoIncrement;
  int? currentStreak;
  int? longestStreak;
  DateTime? lastUpdated;
  DateTime? lastCompletedDate;
  DateTime? streakStartDate;
  Streak({
    this.currentStreak,
    this.longestStreak,
    this.lastUpdated,
    this.lastCompletedDate,
    this.streakStartDate,
  });
} 