
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/models/Offine/Habit.dart';

class HabitRepositoryOnline{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? get userID => _auth.currentUser?.uid;
  // add habit to firebase
  Future<void> addHabitToFirebase(Habit habit) async{
    try{
      if(userID == null) throw Exception("User haven't log in");
      final habitRef = await _firestore
          .collection("users")
          .doc(userID)
          .collection("Habits")
          .add({
            'title':habit.title,
            'description':habit.description,
            'due_time': habit.due_time,
            'due_date': habit.due_date,
            'isCompleted': habit.isCompleted,
            'frequency_type': habit.frequency_type,
            'target_count': habit.target_count,
            'start_date': habit.start_date,
            'color': habit.color,
            'userEmail': _auth.currentUser?.email,
            
          });
         habit.ID = habitRef.id;
    }
    catch(e){
      log("Error adding habit: $e");
    }
  }
  Future<List<Habit>> getHabitsByUseEmail() async{
    try{
      if(this.userID == null){
        throw Exception("User haven't log in");
      } 
      final habitSnapshot = await _firestore
          .collection("users")
          .doc(userID)
          .collection("Habits")
          .get();
      return habitSnapshot.docs.map((doc){
        final data = doc.data();
        return Habit.fromJson(data)..ID = doc.id;
      }).toList();
      }
      catch(e){
        log("Error getting habits: $e");
        return [];
      }
    }
    Future<void> updateHabitToFirebase(Habit habit) async{
      try{
        if(userID == null && habit.ID == null) throw Exception("User haven't log in or habit ID is null");
        await _firestore
            .collection("users")
            .doc(userID)
            .collection("Habits")
            .doc(habit.ID)
            .update({
              'title': habit.title,
              'description': habit.description,
              'due_time': habit.due_time,
              'due_date': habit.due_date,
              'isCompleted': habit.isCompleted,
              'frequency_type': habit.frequency_type,
              'target_count': habit.target_count,
              'start_date': habit.start_date,
              'color': habit.color,
              'userEmail': _auth.currentUser?.email,
              
            });
      }
      catch(e){
        log("Error updating habit: $e");
      }
    }
    Future<void> deleteHabitToFirebase(Habit habit) async{
      try{
        if(userID == null && habit.ID == null) throw Exception("User haven't log in or habit ID is null");
        await _firestore
            .collection("users")
            .doc(userID)
            .collection("Habits")
            .doc(habit.ID)
            .delete();
      }
      catch(e){
        log("Error deleting habit: $e");
      }
    }
  }
