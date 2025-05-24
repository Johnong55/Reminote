import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/models/Offine/Streak.dart';

class StreakRepositoryOnline {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get userID => _auth.currentUser?.uid;

  Future<List<Streak>> getStreakByUserEmail() async {
    try {
      if (this.userID == null) {
        throw Exception("User hasn't logged in");
      }
      final streakSnapshot = await _firestore
          .collection("users")
          .doc(userID)
          .collection("Streak")
          .get();
      return streakSnapshot.docs.map((doc) {
        final data = doc.data();
        return Streak.fromJson(data);
      }).toList();
    } catch (e) {
      log("Error while fetching streaks: $e");
      return [];
    }
  }

  Future<void> addStreakToFireBase(Streak streak) async {
    try {
      if (this.userID == null) {
        throw Exception("User hasn't logged in");
      }
      if(streak.ID == null) {
       await _firestore
          .collection("users")
          .doc(userID)
          .collection("Streak")
          .add(streak.toJson()).then((value) {
        streak.ID = value.id;
          });
      }
      else{
        updateStreakInFireBase(streak);
      }
      log("Streak added to Firestore: ${streak.toJson()}");  
      log("Streak added successfully");
    } catch (e) {
      log("Error while adding streak: $e");
    }
    
  }

  Future<void> updateStreakInFireBase(Streak streak) async {
    try {
      if (this.userID == null) {
        throw Exception("User hasn't logged in");
      }
      await _firestore
          .collection("users")
          .doc(userID)
          .collection("Streak")
          .doc(streak.ID)
          .update(streak.toJson());
      log("Streak updated successfully");
    } catch (e) {
      log("Error while updating streak: $e");
    }
  }
}
