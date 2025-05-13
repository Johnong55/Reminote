import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/Offline_Repository/Habit_repository.dart';
import 'package:study_app/Online_Repository/Habit_Repository_Online.dart';
import 'package:study_app/models/Offine/Habit.dart';
import 'package:study_app/services/CompletionService.dart';

class HabitService {
  final HabitRepository _offlineRepo = HabitRepository();
  final CompletionService completionService = CompletionService();
  final HabitRepositoryOnline _onlineRepo = HabitRepositoryOnline();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Connectivity _connectivity = Connectivity();
  bool _isInitialized = false;
  CollectionReference? _cloudCollection;

  // Initialize the database
  Future<void> init() async {
    if (_isInitialized) return;

    await _offlineRepo.initializeIsar();
    final user = _auth.currentUser;
    _cloudCollection = FirebaseFirestore.instance.collection(
      user != null ? 'users/${user.uid}/Habits' : 'Habits',
    );
    if (user == null) {
      print("Warning: User not logged in - Firestore may reject operations");
    }
    _isInitialized = true;
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

  // Create a habit
  Future<void> addHabit(Habit habit) async {
    habit.ID = "local_${DateTime.now().millisecondsSinceEpoch}";
    habit.userEmail = _auth.currentUser?.email ?? "local_user";

    await _offlineRepo.createHabit(habit);
    if (await _isNetworkAvailable() && _onlineRepo.userID != null) {
      try {
        habit.userEmail = _auth.currentUser?.email;
        await _onlineRepo.addHabitToFirebase(habit);
      } catch (e) {
        log("Error adding habit to Firebase: $e");
        habit.userEmail = "local_user";
        await _offlineRepo.updateHabit(habit);
      }
    }
  }

  // Get all habits
  List<Habit> get allHabits => _offlineRepo.currenthabits;

  // Fetch all habits from DB
  Future<void> refreshHabits() async {
    await _offlineRepo.fetchhabits();
  }

  // Get a habit by ID
  Future<Habit?> getHabitById(int id) async {
    return await _offlineRepo.getHabitById(id);
  }

  // Update an existing habit
  Future<void> updateHabit(Habit habit) async {
    await _offlineRepo.updateHabit(habit);
  }

  // Delete a habit by ID
  Future<void> deleteHabit(int id) async {
    await _offlineRepo.deleteHabit(id);
  }

  // Delete all habits
  Future<void> clearAllHabits() async {
    await _offlineRepo.deleteAllhabits();
  }

  // Toggle a habit's completion state
  Future<void> toggleCompletion(int id, bool isCompleted) async {
    await completionService.recordCompletion(id, DateTime.now());
  }

  // Get habits for a specific day (including repeating ones)
  Future<List<Habit>> getHabitsForDay(DateTime date) async {
    return await _offlineRepo.getListHabitInSpecDay(date);
  }

  // Get only daily habits
  Future<List<Habit>> getDailyHabits(DateTime date) async {
    return await _offlineRepo.getListDailyHabits(date);
  }

  // Get only weekly habits
  Future<List<Habit>> getWeeklyHabits(DateTime date) async {
    return await _offlineRepo.getListWeeklyHabit(date);
  }

  // Get only monthly habits
  Future<List<Habit>> getMonthlyHabits(DateTime date) async {
    return await _offlineRepo.getListMonthlyHabits(date);
  }

  // Get habits filtered by completion
  Future<List<Habit>> getHabitsByCompletion(bool isCompleted) async {
    return await _offlineRepo.findByIsCompleted(isCompleted);
  }

  // Get habits in a date range
  Future<List<Habit>> getHabitsByDateRange(DateTime start, DateTime end) async {
    return await _offlineRepo.findByDateRange(start, end);
  }

  // Count completed habits for a specific day
  Future<int> countCompletedForDay(DateTime date) async {
    return await _offlineRepo.countCompletedhabitsByDay(date);
  }

  // Check if all habits for a day are completed
  Future<bool> areAllHabitsCompleted(DateTime date) async {
    return await _offlineRepo.areAllhabitsCompletedForDay(date);
  }

  Future<void> pullHabitIntoLocal() async {
    log("Pulling habits into local storage...");
    if (await _isNetworkAvailable() && _onlineRepo.userID != null) {
      try {
        final user = _auth.currentUser;
        log("User: ${user?.email}");
        if (user == null) {
          log("Error: User not logged in");
          return;
        }
        final habits = await _onlineRepo.getHabitsByUseEmail();
        log("Fetched ${habits.length} habits from Firebase");
        for (var habit in habits) {
          if (_offlineRepo.currenthabits
              .where((h) => h.ID == habit.ID)
              .isEmpty) {
            habit.userEmail = user.email;
            await _offlineRepo.createHabit(habit);
          }
        }
      } catch (e) {
        log("Sync failed: $e");
      }
    } else {
      log(
        _onlineRepo.userID == null
            ? "Login required to sync"
            : "No network. Will sync later.",
      );
    }
  }

  Future<void> pushHabitToCloud() async {
    if (await _isNetworkAvailable() && _onlineRepo.userID != null) {
      try {
        final user = _auth.currentUser;
        if (user == null) {
          log("Error: User not logged in");
          return;
        }
        await _offlineRepo.fetchhabits();
        List<Habit> habits = _offlineRepo.currenthabits;
        for (var habit in habits) {
          if (habit.userEmail == "local_user") {
            habit.userEmail = user.email;
            _onlineRepo.addHabitToFirebase(habit);
          }
        }
      } catch (e) {
        log("Sync failed: $e");
      }
    } else {
      log(
        _onlineRepo.userID == null
            ? "Login required to sync"
            : "No network. Will sync later.",
      );
    }
  }

  Future<void> syncHabit() async {
    await pullHabitIntoLocal();
    await pushHabitToCloud();
  }

  Future<void> clearLocalHabitsWhenLogout() async {
    final userEmail = _auth.currentUser?.email;

    if (userEmail != null) {
   await _offlineRepo.deleteAllhabits();
      
   
    } else {
      log("Logout failed: user email is null");
    }
  }
}
