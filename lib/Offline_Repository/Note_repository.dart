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
  Future<void> swapNotePosition(Note note) async {
    

    await _isar.writeTxn(() async {
      await _isar.notes.put(note);
    });
    // Refresh the currentNotes list to reflect the changes
    await fetchNote();
    // Sort the currentNotes list to ensure pinned notes are on top
    currentNotes.sort((a, b) {
      if (b.isPinned == true && a.isPinned == false) {
        return 1;
      } else if (a.isPinned == true && b.isPinned == false) {
        return -1;
      }
      return 0;
    });
  }
}