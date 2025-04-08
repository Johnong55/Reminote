import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/models/Note.dart';

class Note_Repository{
  static late Isar _isar;
  final List<Note> currentNotes = [];

  // Make this method static if you're using _isar as static
  Future<void> initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }
  
  // Create a new note
  Future<void> createNote(Note newNote) async{
 
    newNote.createdAt = DateTime.now();
    newNote.updatedAt = DateTime.now();
    // save to db

   await _isar.writeTxn(() async {
  await _isar.notes.put(newNote);
});

    // reread the notes
    fetchNote();
  }
// fetching notes from the database
  Future<void> fetchNote() async{
   final notes = await _isar.notes
    .where()
    .sortByIsPinnedDesc() // Sort pinned notes first (true comes before false)
    .findAll();
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
  // find by title
  Future<List<Note>> findByTitle(String title) async {
    final notes = await _isar.notes.filter().titleEqualTo( title).findAll();
    return notes;
  } 
 
  // swap the note position to the top of list when it is pinned
  
}