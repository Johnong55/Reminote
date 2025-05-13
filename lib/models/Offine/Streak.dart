import 'package:isar/isar.dart';

part 'Streak.g.dart';

@Collection()
class Streak {
  Id id = Isar.autoIncrement;
  String? ID;
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
    this.ID,
  });
  @override
  String toString() {
    // TODO: implement toString
    return 'Streak{id: $id, ID: $ID, currentStreak: $currentStreak, lastUpdated: $lastUpdated, lastCompletedDate: $lastCompletedDate, streakStartDate: $streakStartDate, userID: $userID}';
  }
}
