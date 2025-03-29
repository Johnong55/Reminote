import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/models/Note.dart';

class Note_Repository{
  static late Isar _isar;
  // INIT THE DATABASE
  final List<Note> currentNotes = [];
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([NoteSchema], directory: dir.path);
  }
  // Create a new note
  Future<void> createNote(String title) async{
    final newNote = Note(title: title);

    // save to db

   await _isar.writeTxn(() async {
  await _isar.notes.put(newNote);
});

    // reread the notes
    fetchNote();
  }
// fetching notes from the database
  Future<void> fetchNote() async{
    final notes = await _isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(notes);
  }

// update notes 
  Future<void> updateNote(Note note) async{
    await _isar.writeTxn(() async{
      await _isar.notes.put(note);
    });
    fetchNote();
  }
// delete notes
  Future<void> deleteNote(Note note) async{
    await _isar.writeTxn(() async {
      await _isar.notes.delete(note.id!);

    });

    fetchNote();
  }


}