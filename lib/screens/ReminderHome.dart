
import 'package:flutter/material.dart';
import 'package:study_app/components/widgets/List_Streak.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => ReminderState();
}

class ReminderState extends State<Reminder> {
  List<Reminder> reminders = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: ListStreak(),
    );
  }
}