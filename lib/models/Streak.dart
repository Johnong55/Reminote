
import 'package:isar/isar.dart';
import 'package:study_app/models/User.dart';

part 'Streak.g.dart';

@Collection()
class Streak{
  Id id = Isar.autoIncrement;
  int? currentStreak;
  DateTime? lastUpdated;
  DateTime? lastCompletedDate;
  DateTime? streakStartDate;
  String? userID;
  Streak({
    this.currentStreak,
    this.lastUpdated,
    this.lastCompletedDate,
    this.streakStartDate,
    this.userID,
  });
  void addTheStreak()
  {
    this.currentStreak = (this.currentStreak ?? 0) + 1;
  }
} 