import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/components/commons/dialog/ColorPickerDialog.dart';
import 'package:study_app/components/widgets/bottom_nav.dart';
import 'package:study_app/providers/note_provider.dart';
import 'package:study_app/Page/Screens/NoteHome.dart';
import 'package:study_app/Page/Screens/HabitPage.dart';
import 'package:study_app/config/app_theme.dart';

import 'package:study_app/models/Note.dart';
import 'package:intl/intl.dart';
import 'package:study_app/utils/Color_helper.dart';

class NoteDetailPage extends StatefulWidget {
  final Note note;

  NoteDetailPage({super.key, required this.note});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isEditing = false;
  bool _isPinned = false;
  bool _contentChanged = false;
  late NoteProvider _noteProvider;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content ?? '');
    _isPinned = widget.note.isPinned ?? false;
   
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Lưu tham chiếu Provider khi dependencies thay đổi
    _noteProvider = Provider.of<NoteProvider>(context, listen: false);
  }

  @override
  void dispose() {
   
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  void showColorPickerDiaglog() {
    showDialog(
      context: context,
      builder: (context) {
        return ColorPickerDialog(
          initialColor: widget.note.color ?? '#FFFFFF',
          onColorSelected: (color) {
            setState(() {
              widget.note.color = color;
              _contentChanged = true;
            });
          },
        );
      },
    );
  }

  Future<void> _saveNoteWithoutFeedback() async {
    final updatedNote = widget.note;
    updatedNote.title = _titleController.text;
    updatedNote.content = _contentController.text;
    updatedNote.isPinned = _isPinned;
    updatedNote.updatedAt = DateTime.now();
    await _noteProvider.updateNote(updatedNote); // Sử dụng tham chiếu đã lưu
  }

  Future<void> _saveNote() async {
    await _saveNoteWithoutFeedback();
    
    setState(() {
      _isEditing = false;
      _contentChanged = false;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Note saved',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
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
    Color_helper colorHelper = Color_helper();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    // Sử dụng Consumer để lắng nghe thay đổi từ NoteProvider
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, child) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            backgroundColor: colorScheme.background,
            appBar: AppBar(
              title: _isEditing 
                  ? TextField(
                      controller: _titleController,
                      style: textTheme.headlineMedium,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter title',
                        hintStyle: textTheme.headlineMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      onChanged: (_) => setState(() => _contentChanged = true),
                    )
                  : Text(
                      widget.note.title ?? 'Untitled Note',
                      style: textTheme.headlineMedium,
                    ),
              actions: [
                IconButton(
                  onPressed: showColorPickerDiaglog,
                  icon: Icon(
                    Icons.circle,
                    color: widget.note.color != null ? colorHelper.HexToColor(widget.note.color!) : colorScheme.primary,
                  )
                ),
                IconButton(
                  icon: Icon(
                    _isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                    color: _isPinned ? colorScheme.surfaceVariant : null,
                  ),
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
                  Card(
                    
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          if (widget.note.createdAt != null)
                            Expanded(
                              child: Text(
                                'Created: ${_formatDate(widget.note.createdAt)}',
                                style: textTheme.bodySmall,
                              ),
                            ),
                        
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _isEditing
                      ? TextField(
                          controller: _contentController,
                          decoration: InputDecoration(
                            hintText: 'Enter your note content here...',
                            border: InputBorder.none,
                            hintStyle: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          style: textTheme.bodyLarge,
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
                            style: textTheme.bodyLarge,
                          ),
                        ),
                  ),
                ],
              ),
            ),
            floatingActionButton: _isEditing && _contentChanged ? 
              FloatingActionButton(
                onPressed: () => _saveNote(),
                backgroundColor: colorScheme.tertiary,
                child: Icon(Icons.save, color: colorScheme.onPrimary),
              ) : null,
          ),
        );
      },
    );
  }
}