import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'Reminder.g.dart';

@collection
class Reminder {
  Id id = Isar.autoIncrement;
  String? title;
  String? description;
  DateTime? due_time;
  @Index()
  DateTime? due_date;
  @Index()
  bool? isCompleted;
  int? frequency_type; // Frequency type (e.g., daily, weekly, etc.)
  int? target_count; // Number of times the reminder should be completed
  int? start_date;
  String? color;
  Reminder({
    this.title,
    this.description,
    this.due_date,
    this.due_time,
    this.isCompleted,
    this.frequency_type,
    this.target_count,
    this.start_date,
    this.color,
  });
}
