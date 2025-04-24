import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:study_app/models/Note.dart';
import 'package:study_app/services/NoteService.dart';

class NoteProvider extends ChangeNotifier {
  final NoteService _noteService = NoteService();

  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  Note? _currentNote;
  bool _isLoading = false;
  String _searchQuery = '';

  bool _isSyncing = false;

  // Getters
  List<Note> get notes => _notes;
  List<Note> get filteredNotes => _filteredNotes;
  List<Note> get pinnedNotes => _notes.where((note) => note.isPinned == true).toList();
  List<Note> get unpinnedNotes => _notes.where((note) => note.isPinned != true).toList();
  Note? get currentNote => _currentNote;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  bool get isSyncing => _isSyncing;

  // Initialize the provider
  Future<void> initialize() async {
    _setLoading(true);
    await _noteService.initialize();
    await fetchAllNotes();
   
    _setLoading(false);
  }

  // Fetch all notes
  Future<void> fetchAllNotes() async {
    log("===========================");
    _setLoading(true);
    _notes =  await _noteService.getAllNotes();
    log(_notes.length.toString());
    _sortNotes();
    _applyFilter();
    _setLoading(false);
    notifyListeners();
  }

 Future<void> createNote(Note newNote) async {
  _setLoading(true);
  
  try {
    // Log trước khi tạo
    log("Đang tạo ghi chú: ${newNote.title}");
    print("ID trước khi tạo: ${newNote.ID}");
    
    // Tạo ghi chú
    await _noteService.createNote(newNote);
    log("Tạo ghi chú thành công");
    
    // Đảm bảo danh sách được cập nhật
    await fetchAllNotes();
    log("Đã cập nhật danh sách");

  } catch (e) {
    log("Lỗi khi tạo ghi chú: $e");
  } finally {
    _setLoading(false);
  }
}
  // Update an existing note
  Future<void> updateNote(Note note) async {
    _setLoading(true);
    await _noteService.updateNote(note);

    final index = _notes.indexWhere((n) => n.ID == note.ID);
    if (index != -1) _notes[index] = note;

    if (_currentNote?.ID == note.ID) _currentNote = note;

   await fetchAllNotes();
    
    _setLoading(false);
    notifyListeners();
  }

  // Delete a note
  Future<void> deleteNote(Note note) async {
    _setLoading(true);
    await _noteService.deleteNote(note);
    _notes.removeWhere((n) => n.ID == note.ID);
    _filteredNotes.removeWhere((n) => n.ID == note.ID);

    if (_currentNote?.ID == note.ID) _currentNote = null;
    fetchAllNotes();
    _setLoading(false);
    notifyListeners();
  }

  // Toggle pin
  Future<void> togglePinStatus(Note note) async {
    await _noteService.togglePin(note);
    await fetchAllNotes();
  }

  // Set current note
  void setCurrentNote(Note? note) {
    _currentNote = note;
    notifyListeners();
  }

  // Search notes
  Future<void> searchNotes(String query) async {
    _searchQuery = query.trim();
    _setLoading(true);

    if (_searchQuery.isEmpty) {
      _filteredNotes = _notes;
    } else {
    
      _filteredNotes = await _noteService.searchByText(_searchQuery);
      
    }

    _sortNotes();
    _setLoading(false);
    notifyListeners();
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _filteredNotes = _notes;
    notifyListeners();
  }

  // Filter by category
  Future<void> filterByCategory(String category) async {
    _setLoading(true);
    if (category.isEmpty) {
      _filteredNotes = _notes;
    } else {
      _filteredNotes = _notes.where((note) => note.category == category).toList();
    }
    _sortNotes();
    _setLoading(false);
    notifyListeners();
  }

  // Sort notes
  void _sortNotes() {
    _notes.sort((a, b) {
      final aPinned = a.isPinned ?? false;
      final bPinned = b.isPinned ?? false;
      final pinCompare = (bPinned ? 1 : 0).compareTo(aPinned ? 1 : 0);
      if (pinCompare != 0) return pinCompare;
      return (b.updatedAt ?? DateTime.now()).compareTo(a.updatedAt ?? DateTime.now());
    });
    
    
  }

  // Apply search filter
  void _applyFilter() {
    if (_searchQuery.isNotEmpty) {
      searchNotes(_searchQuery);
    } else {
      _filteredNotes = _notes;
    }
  }

  // Sync notes manually
  Future<void> syncNotes() async {
    _isSyncing = true;
    notifyListeners();
    try {
      await _noteService.syncAllNotes();
      await fetchAllNotes();
   
    } catch (e) {
      log('Error syncing notes: $e');
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  // Force sync from server
  Future<void> pullFromFirebase() async {
    _isSyncing = true;
    notifyListeners();
    try {
      await _noteService.pullFromFirebase();
      await fetchAllNotes();
    } catch (e) {
      log('Error pulling notes: $e');
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }


  // Helper to toggle loading
  void _setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }
  Future<void> deleteWhenLogout() async{
    _isLoading = true;
    await _noteService.clearLocalNotesWhenLogout();
    _isLoading = false;
    fetchAllNotes();
   
  }
}
