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
    return 'Streak{id: $id, ID: $ID, currentStreak: $currentStreak, lastUpdated: $lastUpdated, lastCompletedDate: $lastCompletedDate, streakStartDate: $streakStartDate, userID: $userID}';
  }

  factory Streak.fromJson(Map<String, dynamic> json) {
    return Streak(
      currentStreak: json['currentStreak'] as int?,
      lastUpdated: json['lastUpdated'] != null ? DateTime.parse(json['lastUpdated']) : null,
      lastCompletedDate: json['lastCompletedDate'] != null ? DateTime.parse(json['lastCompletedDate']) : null,
      streakStartDate: json['streakStartDate'] != null ? DateTime.parse(json['streakStartDate']) : null,
      userID: json['userID'] as String?,
      ID: json['ID'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ID': ID,
      'currentStreak': currentStreak,
      'lastUpdated': lastUpdated?.toIso8601String(),
      'lastCompletedDate': lastCompletedDate?.toIso8601String(),
      'streakStartDate': streakStartDate?.toIso8601String(),
      'userID': userID,
    };
  }
}
