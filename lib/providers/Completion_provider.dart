import 'package:flutter/material.dart';
import 'package:study_app/models/Completions.dart';
import 'package:study_app/services/CompletionService.dart';

class CompletionProvider extends ChangeNotifier {
  static CompletionService _service = CompletionService();
  DateTime? _currentDate = DateTime.now();
  List<Completions> _completions = [];
  // Getters 
  DateTime? get currentDate => _currentDate;
  List<Completions> get completions => _completions;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void _setloading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  Future<void> intialize() async{
    _setloading(true);
    await _service.initialize();

    await _service.getCompletionsForDate(currentDate!);
    _setloading(false);
}
  Future<void> getCompletionsForDate(DateTime date) async {
    _setloading(true);
    _currentDate = date;
    attachCompletions( await _service.getCompletionsForDate(date));
    _setloading(false);
  }
  Future<void> recordCompletions(int habit, DateTime date, bool isCompleted) async {
    _setloading(true);
    await _service.recordCompletion(habit, isCompleted, date);
    await getCompletionsForDate(date);
    _setloading(false);
  }

  Future<void> attachCompletions(List<Completions> completions) async {
     _completions.clear();
     _completions.addAll(completions);

  
  }

  Future<bool> isHabitCompleted(int habitID, DateTime date) async{
    return await _service.isHabitCompleted(habitID, date);
  }

}