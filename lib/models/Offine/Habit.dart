import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:study_app/enums/FrequencyType.dart';


// Define the enum outside the class


part 'Habit.g.dart';

@collection
class Habit {
  Id id = Isar.autoIncrement;

  String? ID;
  String? title;
  String? description;
  DateTime? due_time;
  
  @Index()
  DateTime? due_date;
  
  @Index()
  bool? isCompleted;
  
  // Keep the original integer field for database compatibility
  int? frequency_type; // Frequency type (e.g., daily, weekly, etc.)
  
  int? target_count; // Number of times the reminder should be completed
  int? start_date;
  String? color;
  @Index()
  String? userEmail;
  
  bool? isSync;
  // Getter to convert the stored integer to enum
  @ignore
  FrequencyType get frequencyType {
    if (frequency_type == null) return FrequencyType.once; // Default value
    if (frequency_type! < 0 || frequency_type! >= FrequencyType.values.length) {
      return FrequencyType.once; // Fallback for invalid values
    }
    return FrequencyType.values[frequency_type!];
  }

  // No need to annotate setters
  set frequencyType(FrequencyType type) {
    frequency_type = type.index;
  }

  // Add the @ignore annotation here too
  @ignore
  Color? get colorAsFlutterColor {
    if (color == null) return null;
    try {
      return Color(int.parse(color!));
    } catch (e) {
      // If color string isn't a valid color int, return null
      return null;
    }
  }
  // Set color from a Flutter Color object
  set colorAsFlutterColor(Color? flutterColor) {
    if (flutterColor == null) {
      color = null;
    } else {
      color = flutterColor.value.toString();
    }
  }

  Habit({
    this.title,
    this.description,
    this.due_date,
    this.due_time,
    this.isCompleted,
    this.frequency_type,
    this.target_count,
    this.start_date,
    this.color,
    this.ID,
    this.userEmail
  });

  // Alternative constructor using the enum
  factory Habit.withEnum({
    String? title,
    String? description,
    DateTime? due_date,
    DateTime? due_time,
    bool? isCompleted,
    FrequencyType? frequencyType,
    int? target_count,
    int? start_date,
    Color? flutterColor,
  }) {
    return Habit(
      title: title,
      description: description,
      due_date: due_date,
      due_time: due_time,
      isCompleted: isCompleted,
      frequency_type: frequencyType?.index,
      target_count: target_count,
      start_date: start_date,
      color: flutterColor?.value.toString(),
    );
  }

  // Create a copy with optional new values
  Habit copyWith({
    String? title,
    String? description,
    DateTime? due_date,
    DateTime? due_time,
    bool? isCompleted,
    FrequencyType? frequencyType,
    int? target_count,
    int? start_date,
    Color? color,
  }) {
    return Habit(
      title: title ?? this.title,
      description: description ?? this.description,
      due_date: due_date ?? this.due_date,
      due_time: due_time ?? this.due_time,
      isCompleted: isCompleted ?? this.isCompleted,
      frequency_type: frequencyType?.index ?? this.frequency_type,
      target_count: target_count ?? this.target_count,
      start_date: start_date ?? this.start_date,
      color: color?.value.toString() ?? this.color,
    );
  }

  @override
  String toString() {
    return 'Habit(id: $id, title: $title, '
           'frequencyType: ${frequencyType?.name}, '
           'due_date: $due_date, isCompleted: $isCompleted)'
           'start_date: $start_date, color: $color)';   
  }

  static Habit fromJson(Map<String, dynamic> data) {
    return Habit(
      title: data['title'] as String?,
      description: data['description'] as String?,
      due_date: data['due_date'] != null ? (data['due_date'] as firestore.Timestamp?)?.toDate(): null,
      due_time: data['due_time'] != null ? (data['due_time'] as firestore.Timestamp?)?.toDate() : null,
      isCompleted: data['isCompleted'] as bool?,
      frequency_type: data['frequency_type'] as int?,
      target_count: data['target_count'] as int?,
      start_date: data['start_date'] as int?,
      color: data['color'] as String?,
      ID: data['ID'] as String?,
      userEmail: data['userEmail'] as String?,
    );
  }
}