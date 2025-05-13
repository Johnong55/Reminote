import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/models/Offine/Completions.dart';

class CompletionRepositoryOnline {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? get userID => _auth.currentUser?.uid;
  // add Completion to firebase
  Future<Completions> addCompletionToFirebase(Completions completion) async {
    try {
      if (userID == null) throw Exception("User haven't log in");
      final completionRef = await _firestore
          .collection("users")
          .doc(userID)
          .collection("Completions")
          .add({
            'habitID': completion.habitID,
            'completedDate': completion.dateCompleted,
            'userEmail': completion.userEmail,
            'completed': completion.isCompleted,
          });
          completion.ID = completionRef.id;
      return Completions(
        ID: completionRef.id,
        habitID: completion.habitID,
        dateCompleted: completion.dateCompleted,
        isCompleted: completion.isCompleted,
      );
    } catch (e) {
      log("Error adding completion: $e");
    }
    return Completions(
      ID: "Local",
      habitID: completion.habitID,
      dateCompleted: completion.dateCompleted,
      isCompleted: completion.isCompleted,
    );
  }

  Future<List<Completions>> getCompletionsByUserEmail() async {
    try {
      if (this.userID == null) throw Exception("User haven't log in");
      final completionSnapshot =
          await _firestore
              .collection("users")
              .doc(userID)
              .collection("Completions")
              .get();
      return completionSnapshot.docs.map((doc) {
        final data = doc.data();
        return Completions.fromJson(data)..ID = doc.id;
      }).toList();
    } catch (e) {
      log("Error getting completions: $e");
      return [];
    }
  }

  Future<void> updateCompletionToFirebase(Completions completion) async {
    try {
      if (userID == null) throw Exception("User haven't log in");
      await _firestore
          .collection("users")
          .doc(userID)
          .collection("Completions")
          .doc(completion.ID)
          .update({
            'completed': completion.isCompleted,
            'completedDate': completion.dateCompleted,
          });
    } catch (e) {
      log("Error updating completion: $e");
    }
  }

  Future<void> deleteCompletionFromFirebase(String completionID) async {
    try {
      if (userID == null) throw Exception("User haven't log in");
      await _firestore
          .collection("users")
          .doc(userID)
          .collection("Completions")
          .doc(completionID)
          .delete();
    } catch (e) {
      log("Error deleting completion: $e");
    }
  }

  Future<void> deleteAllCompletionsFromFirebase() async {
    try {
      if (userID == null) throw Exception("User haven't log in");
      final completionSnapshot =
          await _firestore
              .collection("users")
              .doc(userID)
              .collection("Completions")
              .get();
      for (var doc in completionSnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      log("Error deleting all completions: $e");
    }
  }
}
