import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/Page/Screens/NoteDetailPage.dart';
import 'package:study_app/components/commons/dialog/AddNoteDialog.dart';
import 'package:study_app/components/commons/Note_Tile.dart';
import 'package:study_app/models/Offine/Note.dart';
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
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng listen: true để widget rebuild khi dữ liệu thay đổi
    final noteProvider = Provider.of<NoteProvider>(context, listen: true);
    final notes = noteProvider.notes; // Lấy danh sách notes từ provider
    final filteredNotes = noteProvider.searchQuery.isEmpty ? notes : noteProvider.filteredNotes;

    // Chia danh sách thành 2 mục: ghim và chưa ghim
    final pinnedNotes = filteredNotes.where((note) => note.isPinned == true).toList();
    final unpinnedNotes = filteredNotes.where((note) => note.isPinned != true).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: filteredNotes.isEmpty
          ? Center(
              child: Text(
                'No notes yet. Tap + to add a new note',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              ),
            )
          : ListView(
              children: [
                // Hiển thị mục ghim chỉ khi có note được ghim
                if (pinnedNotes.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                    child: Text(
                      'Pinned',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                  ...pinnedNotes.map((note) => _buildNoteTile(note, noteProvider)),
                  const Divider(height: 20),
                ],
                
                // Mục chưa ghim luôn hiển thị khi có note chưa ghim
                if (unpinnedNotes.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Text(
                      'Notes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                  ...unpinnedNotes.map((note) => _buildNoteTile(note, noteProvider)),
                ],
              ],
            ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addNote',
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

  Widget _buildNoteTile(Note note, NoteProvider noteProvider) {
    return NoteTile(
      note: note,
      onTap: () {
        log(" USER Email : ${note.userEmail.toString()}");
        log("SyncStatus : ${note.syncStatus.toString()}");
        _navigateToEditNote(note);
      },
      onDelete: () async {
        await noteProvider.deleteNote(note);
      },
      onPin: () async {
        final updatedNote = note;
        updatedNote.isPinned = !(updatedNote.isPinned ?? false);
        await noteProvider.updateNote(updatedNote);
      },
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