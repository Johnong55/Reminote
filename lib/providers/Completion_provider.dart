import 'package:flutter/material.dart';
import 'package:study_app/models/Completions.dart';
import 'package:study_app/services/CompletionService.dart';

class CompletionProvider extends ChangeNotifier {
  static CompletionService _service = CompletionService();
  DateTime? _currentDate = DateTime.now();
  List<Completions> _completions = [];
  bool? _completed = false;
  // Getters 
  DateTime? get currentDate => _currentDate;
  List<Completions> get completions => _completions;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get completed => _completed!;
  void _setloading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  Future<void> intialize() async{
    _setloading(true);
    await _service.initialize();

    await _service.getCompletionsForDate(currentDate!);
    _completed = await _service.wereAllCompletedOnDate(currentDate!);
    _setloading(false);
}
  Future<void> getCompletionsForDate(DateTime date) async {
    _setloading(true);
    _currentDate = date;
    attachCompletions( await _service.getCompletionsForDate(date));
    _setloading(false);
       notifyListeners();
  
  }
  Future<void> recordCompletions(int habit, DateTime date, bool isCompleted) async {
    _setloading(true);
    await _service.recordCompletion(habit,  date);
    await getCompletionsForDate(date);
      _completed = await _service.wereAllCompletedOnDate(currentDate!);
    _setloading(false);
       notifyListeners();
  
  }

  Future<void> attachCompletions(List<Completions> completions) async {
     _completions.clear();
     _completions.addAll(completions);
    notifyListeners();
  
  }

Future<bool> isHabitCompleted(int habitID, DateTime date) async {
    return await _service.isHabitCompleted(habitID, date) ;
}
Future<bool> wereCompletedonDate() async {
  // KHÔNG gọi _setloading ở đây
 _completed  =   await _service.wereAllCompletedOnDate(DateTime.now());
 notifyListeners();
 return _completed!;
}


  Future<void> setCurrentDate(DateTime date) async {
    _currentDate = date;

    notifyListeners();
  }
  Future<void> clearCompletions() async {
    _completions.clear();
    _service.deleteAllCompletions();
    notifyListeners();
  }
}