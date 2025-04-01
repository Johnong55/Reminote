import 'package:flutter/material.dart';
import 'package:study_app/Offline_Repository/Note_repository.dart';
import 'package:study_app/components/commons/confirm_dialog.dart';
import 'package:study_app/components/widgets/Note_Tile.dart';
import 'package:study_app/models/Note.dart';

class Notehome extends StatefulWidget {
  // final Note note;

  const Notehome({super.key});

  @override
  State<Notehome> createState() => _NotehomeState();
}
class _NotehomeState extends State<Notehome> {
  final Note_Repository _repository = Note_Repository();
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }
// loadnotes from the database
  Future<void> _loadNotes() async {
    await _repository.fetchNote();
    setState(() {
      notes = _repository.currentNotes;
    });
  }
  // Rerange the notes in the current note


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to create note screen or show dialog
              _showAddNoteDialog();
            },
          ),
        ],
      ),
      body: notes.isEmpty
          ? const Center(
            
              child: Text(
                'No notes yet. Tap + to add a new note',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteTile(
                  note: notes[index],
                  onTap: () {
                    // Navigate to edit note screen
                    _navigateToEditNote(notes[index]);
                  },
                  onDelete: () async {
                    await _repository.deleteNote(notes[index]);
                    _loadNotes();
                 // Close the confirmation dialog
                  },
                  onPin: () async {
                    print("Pin pressed");
                    final updatedNote = notes[index];
                    updatedNote.isPinned = !(updatedNote.isPinned ?? false);
                    await _repository.updateNote(updatedNote);
                    
                    _loadNotes();
                  },
                );
              },
            ),
    );
  }

  void _showAddNoteDialog() {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Note'),
          content: TextField(
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            // titleController ,
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Enter note title', focusColor: Colors.white,
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty) {
                  await _repository.createNote(titleController.text);
                  _loadNotes();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add',
                style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold),  
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditNote(Note note) {

    print("hehe");
  }
}