import 'package:flutter/material.dart';
import 'package:study_app/models/Note.dart';
import 'package:study_app/Offline_Repository/Note_repository.dart';

class NoteProvider extends ChangeNotifier {
  final Note_Repository _repository = Note_Repository();
  List<Note> _notes = [];
  Note? _currentNote;
  bool _isLoading = false;

  // Getters
  List<Note> get notes => _notes;
  List<Note> get pinnedNotes => _notes.where((note) => note.isPinned == true).toList();
  List<Note> get unpinnedNotes => _notes.where((note) => note.isPinned != true).toList();
  Note? get currentNote => _currentNote;
  bool get isLoading => _isLoading;

  // Initialize
  Future<void> initialize() async {
    await _repository.initializeIsar();
    await fetchAllNotes();
  }
  Future<void> searchNotes(String title) async {
    _setLoading(true);
    _notes = await _repository.findByTitle(title);
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

  // Helper
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}