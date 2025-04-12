import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:study_app/models/Note.dart';
import 'package:study_app/Offline_Repository/Note_repository.dart';

class NoteProvider extends ChangeNotifier {
  final Note_Repository _repository = Note_Repository();
  List<Note> _notes = [];
  List<Note> _filterNotes = [];
  Note? _currentNote;
  bool _isLoading = false;
  String _searchQuery = '';
  // Getters
  List<Note> get notes => _notes;
  List<Note> get pinnedNotes => _notes.where((note) => note.isPinned == true).toList();
  List<Note> get unpinnedNotes => _notes.where((note) => note.isPinned != true).toList();
  Note? get currentNote => _currentNote;
  bool get isLoading => _isLoading;
  List<Note> get filterNotes => _filterNotes;
  String get searchQuery => _searchQuery;
  // Initialize
  Future<void> initialize() async {
    await _repository.initializeIsar();
    await fetchAllNotes();
  }
  Future<void> searchNotes(String query) async {
      _searchQuery = query.trim();
      _setLoading(true);
      if(_searchQuery.isEmpty){
        _filterNotes = _notes;
      }else{
        _filterNotes  = await _repository.findByString(_searchQuery);
      }
 
      _setLoading(false);
      notifyListeners();
  }
  // CRUD Operations
  Future<void> fetchAllNotes() async {
    _setLoading(true);
    await _repository.fetchNote();
    _notes = _repository.currentNotes;
    _setLoading(false);
    notifyListeners();
  }

  Future<Note> createNote(Note newNote) async {
    _setLoading(true);
    await _repository.createNote(newNote);
    await fetchAllNotes(); // Refresh notes
    _setLoading(false);
    return _notes.firstWhere((note) => note.title == newNote.title && note.createdAt!.isAfter(DateTime.now().subtract(const Duration(seconds: 5))));
  }

  Future<void> updateNote(Note note) async {
    _setLoading(true);
    note.updatedAt = DateTime.now();
    await _repository.updateNote(note);
    
    // Update the note in the local list
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
    }
    
    if (_currentNote?.id == note.id) {
      _currentNote = note;
    }
    
    _setLoading(false);
    notifyListeners();
  }

  Future<void> deleteNote(Note note) async {
    _setLoading(true);
    await _repository.deleteNote(note);
    _notes.removeWhere((n) => n.id == note.id);
    if (_currentNote?.id == note.id) {
      _currentNote = null;
    }
    _setLoading(false);
    notifyListeners();
  }

  // Current Note Management
  void setCurrentNote(Note note) {
    _currentNote = note;
    notifyListeners();
  }

  // Pin/Unpin Note
  Future<void> togglePinStatus(Note note) async {
    note.isPinned = !(note.isPinned ?? false);
    await updateNote(note);
  }
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Xóa query tìm kiếm và hiển thị tất cả notes
  void clearSearch() {
    _searchQuery = '';
    _filterNotes = _notes;
    notifyListeners();
  }

  // Helper
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}