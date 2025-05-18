import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/Offline_Repository/Completions_repository.dart';
import 'package:study_app/Online_Repository/Completion_Repository_Online.dart';
import 'package:study_app/models/Offine/Completions.dart';

class CompletionService {
  final CompletionsRepository _completionsRepository = CompletionsRepository();
  final CompletionRepositoryOnline _completionsRepositoryOnline =
      CompletionRepositoryOnline();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Connectivity _connectivity = Connectivity();

  // Initialize the repository
  Future<void> initialize() async {
    await _completionsRepository.initializeIsar();
    final user = _auth.currentUser;

    if (user == null) {
      print("Warning: User not logged in - Firestore may reject operations");
    }
  }

  // check Authentication
  bool _checkAuth() {
    final user = _auth.currentUser;
    if (user == null) {
      print("Error: User not logged in");
      return false;
    }
    return true;
  }

  // check Network
  Future<bool> _isNetworkAvailable() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  // Record a completion
  Future<void> recordCompletion(
    int habitId,
    DateTime dateCompleted, {
    bool isCompleted = true,
  }) async {
    Completions completions = await _completionsRepository.recordCompletion(
      habitId,
      dateCompleted,
      isCompleted: isCompleted,
    );
    log("needSync ? : ${completions.needsSync}");

    if (_checkAuth()) {
      final isNetworkAvailable = await _isNetworkAvailable();
      if (isNetworkAvailable) {
        if (!completions.needsSync) {
          log("this one have been sync");
          await _completionsRepositoryOnline.updateCompletionToFirebase(
            completions,
          );
        } else {
          log("this one not sync yet, now syncing");
          final completionOnline = await _completionsRepositoryOnline
              .addCompletionToFirebase(completions);
          completions.userEmail = _auth.currentUser?.email;
          await _completionsRepository.markAsSynced(completions);
          completions.ID = completionOnline.ID;
        }

        await _completionsRepository.updateCompletion(completions);
      } else {
        log("Error: No network available for online completion record.");
      }
    } else {
      log("Error: User not authenticated for online completion record.");
    }
  }

  Future<bool> isHabitCompleted(int habitID, DateTime date) async { 
    return await _completionsRepository.isHabitCompletedOnDate(habitID, date);
  }

  // Get completions for a specific date
  Future<List<Completions>> getCompletionsForDate(DateTime date) async {
    return await _completionsRepository.getCompletionsForDate(date);
  }

  // Get completions for a specific habit
  Future<List<Completions>> getCompletionsForHabit(int habitId) async {
    return await _completionsRepository.getCompletionsForHabit(habitId);
  }

  // Delete a completion record
  Future<void> deleteCompletion(int id) async {
    await _completionsRepository.deleteCompletion(id);
  }

  Future<void> deleteAllCompletions() async {
    await _completionsRepository.deleteAllCompletions();
  }

  // Get completions for a date range
  Future<List<Completions>> getCompletionsForDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _completionsRepository.getCompletionsForDateRange(
      startDate,
      endDate,
    );
  }

  Future<List<Completions>> getCompletionsOnline() async {
    List<Completions> completions =
        await _completionsRepositoryOnline.getCompletionsByUserEmail();
    for (Completions i in completions) {

       await _completionsRepository.recordCompletion(
         i.habitID ?? 0, // Provide a default value or handle null
         i.dateCompleted ?? DateTime.now(), // Provide a default value or handle null
         isCompleted: i.isCompleted ?? false,
         needSync: false,
         ID: i.ID ?? "",
       );
      }

    return completions;
  }

  Future<bool> wereAllCompletedOnDate(DateTime date) async {
    return await _completionsRepository.wereAllCompletedOnDate(date);
  }
}
