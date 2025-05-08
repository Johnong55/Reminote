import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/Offline_Repository/Completions_repository.dart';
import 'package:study_app/Online_Repository/Completion_Repository_Online.dart';
import 'package:study_app/models/Completions.dart';

class CompletionService {
  final CompletionsRepository _completionsRepository = CompletionsRepository();
  final CompletionRepositoryOnline _completionsRepositoryOnline =  CompletionRepositoryOnline();
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final Connectivity _connectivity = Connectivity();
   late final CollectionReference _cloudCollection;
  // Initialize the repository
  Future<void> initialize() async {
    await _completionsRepository.initializeIsar();
    final user = _auth.currentUser;
    _cloudCollection = FirebaseFirestore.instance.collection(
      user != null ? 'users/${user.uid}/Completions' : 'Completions',
    );
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
  Future<void> recordCompletion(int habitId,  DateTime dateCompleted , {bool isCompleted = true}) async {
    
    await _completionsRepository.recordCompletion(habitId,  dateCompleted, iscompleted: isCompleted);
    if (_checkAuth()) {
      final isNetworkAvailable = await _isNetworkAvailable();
      if (isNetworkAvailable) {
        await _completionsRepositoryOnline.addCompletionToFirebase(habitId, dateCompleted);
      } else {
        log("Error: No network available for online completion record.");
      }
    } else {
      log("Error: User not authenticated for online completion record.");
    }
  }
  Future<bool> isHabitCompleted(int habitID, DateTime date) async {
    return await _completionsRepository.isHabitCompletedinDate(habitID, date);
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
  Future<List<Completions>> getCompletionsForDateRange(DateTime startDate, DateTime endDate) async {
    return await _completionsRepository.getCompletionsForDateRange(startDate, endDate);
  }
  Future<bool> wereAllCompletedOnDate(DateTime date) async {
    return await _completionsRepository.wereAllCompletedOnDate(date);
  }


}