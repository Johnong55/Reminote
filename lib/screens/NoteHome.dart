import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:study_app/Offline_Repository/Note_repository.dart';
import 'package:study_app/components/commons/AddNoteDialog.dart';
import 'package:study_app/components/commons/confirm_dialog.dart';
import 'package:study_app/components/widgets/Note_Tile.dart';
import 'package:study_app/models/Note.dart';
import 'package:study_app/screens/NoteDetailPage.dart';
import 'package:study_app/services/isar_service.dart';

class Notehome extends StatefulWidget {
  const Notehome({super.key});

  @override
  State<Notehome> createState() => _NotehomeState();
}

class _NotehomeState extends State<Notehome> {
  final NoteService _noteService = NoteService();
  List<Note> notes = [];
  Function(Note) onsaveNote(Note note) {
    print(note.color);   
    return (Note note) async{
      await _noteService.createNote(note);
      setState(() {
        notes.add(note);
        _loadNotes();
      });
    };
  }
  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    await _noteService.getAllNotes();
    setState(() {
      notes = _noteService.currentNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: notes.isEmpty
          ? Center(
              child: Text(
                'No notes yet. Tap + to add a new note',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              ),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteTile(
                  note: notes[index],
                  onTap: () {
                    _navigateToEditNote(notes[index]);
                  },
                  onDelete: () async {
                    await _noteService.deleteNote(notes[index]);
                    _loadNotes();
                  },
                  onPin: () async {
                    final updatedNote = notes[index];
                    updatedNote.isPinned = !(updatedNote.isPinned ?? false);
                    await _noteService.updateNote(updatedNote);
                    _loadNotes();
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 2,
        onPressed: () {

          Note note = Note();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNoteDialog(onSave: onsaveNote(note),note: note,),
            ),
          ).then((_) {
              log("notehome : ${note.color}");
              log("note:${note.toString()}");
            _loadNotes();
          });
       
        },
        backgroundColor: Colors.lightBlue[300],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }


  void _navigateToEditNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailPage(note: note),
      ),
    ).then((_) {
      _loadNotes();
    });
  }
}