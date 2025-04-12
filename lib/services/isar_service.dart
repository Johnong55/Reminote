
import 'package:study_app/models/Note.dart';
import 'package:study_app/Offline_Repository/Note_repository.dart';

class NoteService {
  final Note_Repository _repository = Note_Repository();
  List<Note> currentNotes = [];
  // Khởi tạo service
  Future<void> initialize() async {
    await _repository.initializeIsar();
  }
  
  // Các phương thức CRUD cơ bản
  Future<List<Note>> getAllNotes() async {
    await _repository.fetchNote();
    currentNotes = _repository.currentNotes;
    return currentNotes;
   
  }
  
  Future<void> createNote(Note newNote) async {
    await _repository.createNote(newNote);
  }
  
  Future<void> updateNote(Note note) async {
    await _repository.updateNote(note);
  }
  
  Future<void> deleteNote(Note note) async {
    await _repository.deleteNote(note);
  }
  
  Future<List<Note>> findByTitle(String title) async {
    return await _repository.findByTitle(title);
  }
  Future<List<Note>> findByString(String text) async {
    return await _repository.findByString(text);
  }
  // Logic nghiệp vụ bổ sung
  Future<void> archiveNote(Note note) async {
    // Logic để lưu trữ ghi chú
  }
  
  Future<void> exportNoteAsTxt(Note note) async {
    // Logic để xuất ghi chú dưới dạng TXT
  }
  
  Future<void> createNoteFromTemplate(String templateId) async {
    // Logic để tạo ghi chú từ mẫu
  }
}