import 'package:isar/isar.dart';

part 'Reminder.g.dart';

@collection
class Reminder {
  Id id = Isar.autoIncrement;

  String? title;
  String? description;
  DateTime? dateTime;
  bool? isCompleted;

  Reminder({
    this.title,
    this.description,
    this.dateTime,
    this.isCompleted,
  });


}