import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/Page/Screens/NoteDetailPage.dart';
import 'package:study_app/components/commons/dialog/AddNoteDialog.dart';
import 'package:study_app/components/commons/Note_Tile.dart';
import 'package:study_app/models/Note.dart';
import 'package:study_app/providers/note_provider.dart';

class Notehome extends StatefulWidget {
  
  const Notehome({super.key});

  @override
  State<Notehome> createState() => _NotehomeState();
}

class _NotehomeState extends State<Notehome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Gọi fetchAllNotes từ noteProvider để lấy dữ liệu từ repository
      Provider.of<NoteProvider>(context, listen: false).fetchAllNotes();
    });
  }

  Function(Note) onsaveNote(Note note) {
   
    return (Note note) async {
      final noteProvider = Provider.of<NoteProvider>(context, listen: false);
      await noteProvider.createNote(note);
      setState(() {
        
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng listen: true để widget rebuild khi dữ liệu thay đổi
    final noteProvider = Provider.of<NoteProvider>(context, listen: true);
    final notes = noteProvider.notes; // Lấy danh sách notes từ provider
    final filteredNotes =noteProvider.searchQuery.isEmpty?notes:noteProvider.filteredNotes;


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: filteredNotes.isEmpty
          ? Center(
              child: Text(
                'No notes yet. Tap + to add a new note',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              ),
            )
          : ListView.builder(
              itemCount: filteredNotes.length,
              itemBuilder: (context, index) {
                return NoteTile(
                  note: filteredNotes[index],
                  onTap: () {
                    log(" USER Email : ${filteredNotes[index].userEmail.toString()}");
                    log("SyncStatus : ${filteredNotes[index].syncStatus.toString()}");
                    _navigateToEditNote(filteredNotes[index]);

                  },
                  onDelete: () async {
                    await noteProvider.deleteNote(filteredNotes[index]);
                  },
                  onPin: () async {
                    final updatedNote = filteredNotes[index];
                    updatedNote.isPinned = !(updatedNote.isPinned ?? false);
                    await noteProvider.updateNote(updatedNote);
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
              builder: (context) => AddNoteDialog(onSave: onsaveNote(note), note: note),
            ),
          ).then((_) {
         noteProvider.fetchAllNotes(); 
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
      // Refresh từ provider nếu cần
      Provider.of<NoteProvider>(context, listen: false).fetchAllNotes();
    });
  }
}