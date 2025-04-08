import 'package:flutter/material.dart';
import 'package:study_app/components/commons/bottom_nav.dart';
import 'package:study_app/screens/NoteHome.dart';
import 'package:study_app/screens/ReminderHome.dart';
import 'package:study_app/config/app_theme.dart';
import 'package:study_app/Offline_Repository/Note_repository.dart';
import 'package:study_app/models/Note.dart';
import 'package:intl/intl.dart';

class NoteDetailPage extends StatefulWidget {
  final Note note;

  const NoteDetailPage({super.key, required this.note});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  final Note_Repository _repository = Note_Repository();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isEditing = false;
  bool _isPinned = false;
  bool _contentChanged = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content ?? '');
    _isPinned = widget.note.isPinned ?? false;
  }

  @override
  void dispose() {
    if (_contentChanged) {
      _saveNoteWithoutFeedback();
    }
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNoteWithoutFeedback() async {
    final updatedNote = widget.note;
    updatedNote.title = _titleController.text;
    updatedNote.content = _contentController.text;
    updatedNote.isPinned = _isPinned;
    updatedNote.updatedAt = DateTime.now();
    
    await _repository.updateNote(updatedNote);
  }

  Future<void> _saveNote() async {
    await _saveNoteWithoutFeedback();
    
    setState(() {
      _isEditing = false;
      _contentChanged = false;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note saved')),
      );
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  Future<bool> _onWillPop() async {
    if (_contentChanged) {
      await _saveNoteWithoutFeedback();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: _isEditing 
              ? TextField(
                  controller: _titleController,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter title',
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                  ),
                  onChanged: (_) => setState(() => _contentChanged = true),
                )
              : Text(widget.note.title ?? 'Untitled Note',
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
          actions: [
            IconButton(
              icon: Icon(_isPinned ? Icons.push_pin : Icons.push_pin_outlined),
              onPressed: () {
                setState(() {
                  _isPinned = !_isPinned;
                  _contentChanged = true;
                });
              },
              tooltip: 'Pin/Unpin note',
            ),
            IconButton(
              icon: Icon(_isEditing ? Icons.visibility : Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              tooltip: _isEditing ? 'View mode' : 'Edit mode',
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (_contentChanged) {
                await _saveNoteWithoutFeedback();
              }
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    if (widget.note.createdAt != null)
                      Expanded(
                        child: Text(
                          'Created: ${_formatDate(widget.note.createdAt)}',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontSize: 12),
                        ),
                      ),
                    if (widget.note.updatedAt != null)
                      Expanded(
                        child: Text(
                          'Updated: ${_formatDate(widget.note.updatedAt)}',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: _isEditing
                  ? TextField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        hintText: 'Enter your note content here...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                      ),
                      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onBackground),
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      onChanged: (_) => setState(() => _contentChanged = true),
                    )
                  : SingleChildScrollView(
                      child: Text(
                        _contentController.text.isEmpty 
                            ? 'No content. Tap edit to add content.' 
                            : _contentController.text,
                        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
