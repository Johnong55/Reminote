import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:study_app/models/Habit.dart';
import 'package:study_app/services/HabitService.dart';

class HabitProvider extends ChangeNotifier { 
final HabitService _service  =  HabitService();
List<Habit>  _habits   = [];
List<Habit> _filterHabits = [];
Habit? _currentHabit ;
 bool _isLoading = false;
 String _searchType = '';

DateTime? _currentDate ;
 // Getters 
 List<Habit> get habits  => _habits;
 List<Habit> get filterHabits => _filterHabits;
 Habit? get currentHabit => _currentHabit;
 bool get isLoading => _isLoading;
 String get searchType => _searchType;
DateTime? get currentDate => _currentDate;
Future<void> intialize() async{
    _setLoading(true);
    await _service.init();
    await fetchHabits(DateTime.now());
    _setLoading(false);
}

Future<void> fetchHabits(DateTime date) async{
    _setLoading(true);
    _habits = await _service.getHabitsForDay(date);
    _setLoading(false);
    notifyListeners();

}
Future<void> createHabit(Habit habit ) async{
  _setLoading(true);
  try{
    log("Creatingg habit ${habit}");
    await _service.addHabit(habit);
    fetchHabits(currentDate?? DateTime.now());

  }
  catch (e) {
    log("error when creating.....");

  }
  finally{
    _setLoading(false);

  }
}// Add this method to your HabitProvider class
Future<void> updateHabit(Habit habit) async {
  _setLoading(true);
  try {
    await _service.updateHabit(habit);
    await fetchHabits(_currentDate ?? DateTime.now());
  } catch (e) {
    log("Error updating habit: $e");
  } finally {
    _setLoading(false);
  }
}
  void _setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
}
void setCurrentDate(DateTime date){
  _currentDate  = date;
  notifyListeners();
  fetchHabits(date);
}

}