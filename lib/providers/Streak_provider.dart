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
    _currentStreakValue = updatedStreak.currentStreak ?? 0;
    _isStreakActive = true;
    _setLoading(false);
  }

  Future<void> setCompletedDay() async {
 
    bool checking = await _completionService.wereAllCompletedOnDate(DateTime.now());
    
    int undone = 4 - currentStreakValue > 0 ? 4 - currentStreakValue : 4;
    undone = checking == true ? undone + 1 : undone ;
    _completedDays = List.generate(undone, (index) => false);
    for(int i =0 ;i < currentStreakValue ; i++)
    {
      _completedDays.add(true);
    }
    notifyListeners();
  }
}
