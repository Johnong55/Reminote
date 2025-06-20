import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:study_app/models/Offine/Streak.dart';
import 'package:study_app/services/CompletionService.dart';

import 'package:study_app/services/StreakService.dart';

class StreakProvider extends ChangeNotifier {
  final StreakService _streakService = StreakService();
  final CompletionService _completionService = CompletionService();
  List<bool> _completedDays = [];
  // Current streak value
  int _currentStreakValue = 0;
  int get currentStreakValue => _currentStreakValue;
  List<bool> get completedDays => _completedDays;
  // Streak status
  bool _isStreakActive = false;
  bool get isStreakActive => _isStreakActive;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {

    await _streakService.init();
    
    await _loadCurrentStreak();
    await _checkStreakStatus();
    _completionService.initialize();
    await setCompletedDay();
    await _streakService.getAllStreaks();

  }

  Future<Streak?> _loadCurrentStreak() async {
    final currentStreak = await _streakService.getCurrentStreak();
    _currentStreakValue = currentStreak?.currentStreak ?? 0;
    notifyListeners();
    return currentStreak;
  }

  Future<void> _checkStreakStatus() async {
    _isStreakActive = await _streakService.isStreakActive();
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Method to call when user completes their daily task
  Future<void> completeToday() async {
    _setLoading(true);
    
    final updatedStreak = await _streakService.updateStreakAfterCompletion();
    await updateStreakIntoFireBase(updatedStreak);
    _currentStreakValue = updatedStreak.currentStreak ?? 0;
    _isStreakActive = true;
    _setLoading(false);
  }
  // Method to call when  user  try to remove completes their daily task
  Future<void> unCompleteToday() async {
    log("==================");
      final updatedStreak = await _streakService.updateStreakAfterUnCompletion();
          await updateStreakIntoFireBase(updatedStreak);
      _currentStreakValue = updatedStreak.currentStreak ?? 0;
      _isStreakActive = false;
      notifyListeners();

  }
  Future<void> getStreakFromFireBase() async {
    await _streakService.getStreakFromFireBase(); 

    
  }
  Future<void> updateStreakIntoFireBase(Streak streak) async {
    await _streakService.updateStreakIntoFireBase(streak);
  }

  Future<void> setCompletedDay() async {
 
    bool checking = await _completionService.wereAllCompletedOnDate(DateTime.now());
    
    int undone = 4 - currentStreakValue >= 0 ? 4 - currentStreakValue : -1;
    undone = checking == true ? undone + 1 : undone ;
    log("undone : ${undone}");
    _completedDays = List.generate(undone < 0 ? 0 : undone, (index) => false);
    for (int i = 0; i < (currentStreakValue >= 5 ? 5 : currentStreakValue); i++)
    {
      _completedDays.add(true);
    }
    log(_completedDays.toString());
    notifyListeners();
  }
  Future<void> deleteStreakWhenLogout() async{
    await _streakService.deleteStreakWhenLogOut();
    _currentStreakValue = 0;
    _isStreakActive = false;
    _completedDays = [];
    notifyListeners();
  }
}
