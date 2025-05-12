import 'package:flutter/material.dart';
import 'package:study_app/models/Offine/Note.dart';

import 'package:study_app/utils/Color_helper.dart';

class AddNoteDialog extends StatefulWidget {
  final Note? note;
  final Function(Note)? onSave;

  const AddNoteDialog({super.key, this.note, this.onSave});

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {

  Color_helper colorHelper = Color_helper();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final List<String> _categories = [
    'Personal',
    'Work',
    'Ideas',
    'Tasks',
    'Other',
  ];

  String _selectedCategory = 'Personal';
  String _selectedColor = '#FFECB3'; // Default color (light amber)
  bool _isPinned = false;

  // Predefined colors for notes
  final List<String> _colorOptions = [
   "#FFFFFF", // White
    "#F8BBD0", // Pink
    "#FFCDD2", // Light Red
    "#FFE0B2", // Light Orange
    "#FFF9C4", // Light Yellow
    "#C8E6C9", // Light Green
    "#B2DFDB", // Light Teal
    "#B3E5FC", // Light Blue
    "#D1C4E9", // Light Purple
  ];

  @override
  void initState() {
    super.initState();

    // If editing an existing note, populate the fields
    if (widget.note != null) {
      _titleController.text = widget.note!.title ?? '';
      _contentController.text = widget.note!.content ?? '';
      _selectedCategory = widget.note!.category ?? 'Personal';
      _isPinned = widget.note!.isPinned ?? false;
      _selectedColor = widget.note!.color ?? _colorOptions[0];
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Convert hex color string to Color
  
  // Determine if text should be dark or light based on background color
  Color _getTextColor(Color backgroundColor) {
    // Calculate luminance - if background is light, text should be dark and vice versa
    return backgroundColor.computeLuminance() > 0.5
        ? Colors.black87
        : Colors.white;
  }

  void _saveNote() {
    final note = widget.note ?? Note();

    note.title = _titleController.text;
    note.content = _contentController.text;
    note.category = _selectedCategory;
    note.isPinned = _isPinned;
    note.color = _selectedColor;
    print("note color ${note.color}" );
    final now = DateTime.now();
    if (note.createdAt == null) {
      note.createdAt = now;
    }
    note.updatedAt = now;

    if (widget.onSave != null) {
      widget.onSave!(note);
    }
   
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final dialogBackgroundColor =
        isDarkMode ? const Color(0xFF1E1E1E) : Colors.grey.shade50;

    return Container(
      height: MediaQuery.of(context).size.height ,
      width: MediaQuery.of(context).size.width,
      color: isDarkMode ? const Color(0xFF121212) : Colors.white,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: dialogBackgroundColor,
        elevation: 0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.note == null ? 'Add Note' : 'Edit Note',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: Icon(
                        _isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                        color:
                            _isPinned
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPinned = !_isPinned;
                        });
                      },
                      tooltip: 'Pin note',
                    ),
                  ],
                ),
      
                const SizedBox(height: 20),
      
                // Title Field
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor:
                        isDarkMode
                            ? Colors.grey.shade800.withOpacity(0.3)
                            : Colors.grey.shade200.withOpacity(0.5),
                    hintText: 'Title',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
      
                const SizedBox(height: 16),
      
                // Content Field
                TextField(
                  controller: _contentController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor:
                        isDarkMode
                            ? Colors.grey.shade800.withOpacity(0.3)
                            : Colors.grey.shade200.withOpacity(0.5),
                    hintText: 'Note content',
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
      
                const SizedBox(height: 20),
      
                // Category Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor:
                        isDarkMode
                            ? Colors.grey.shade800.withOpacity(0.3)
                            : Colors.grey.shade200.withOpacity(0.5),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  items:
                      _categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
      
                const SizedBox(height: 20),
      
                // Color Selection
                Text('Note Color', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 10),
      
                // Color Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      _colorOptions.map((color) {
                        final colorValue = colorHelper.HexToColor(color);
                        final isSelected = _selectedColor == color;
      
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = color;
                            });
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: colorValue,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child:
                                isSelected
                                    ? Icon(
                                      Icons.check,
                                      size: 20,
                                      color: _getTextColor(colorValue),
                                    )
                                    : null,
                          ),
                        );
                      }).toList(),
                ),
      
                const SizedBox(height: 30),
      
                // Note Preview
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorHelper.HexToColor(_selectedColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preview',
                        style: TextStyle(
                          color: _getTextColor(colorHelper.HexToColor(_selectedColor)),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _titleController.text.isEmpty
                                  ? 'Note Title'
                                  : _titleController.text,
                              style: TextStyle(
                                color: _getTextColor(colorHelper.HexToColor(_selectedColor)),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (_isPinned)
                            Icon(
                              Icons.push_pin,
                              size: 16,
                              color: _getTextColor(colorHelper.HexToColor(_selectedColor)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _contentController.text.isEmpty
                            ? 'Note content preview...'
                            : _contentController.text,
                        style: TextStyle(
                          color: _getTextColor(colorHelper.HexToColor(_selectedColor)),
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
      
                const SizedBox(height: 20),
      
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _saveNote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onPrimary,
                   
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:  Text('Save',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSecondary,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
