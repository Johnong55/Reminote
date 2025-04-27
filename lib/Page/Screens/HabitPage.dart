import 'package:flutter/material.dart';
import 'package:study_app/components/commons/List_Streak.dart';

class Habitpage extends StatelessWidget {
  const Habitpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListStreak()
    );
  }
}