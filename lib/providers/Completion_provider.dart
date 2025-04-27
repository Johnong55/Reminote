import 'package:flutter/material.dart';
import 'package:study_app/models/Completions.dart';
import 'package:study_app/services/CompletionService.dart';

class CompletionProvider extends ChangeNotifier {
  static CompletionService _service = CompletionService();
  DateTime? _currentDate;
  List<Completions> _completions = [];
  // Getters 
  DateTime? get currentDate => _currentDate;
  List<Completions> get completions => _completions;
  bool _isLoading = false;
  
}