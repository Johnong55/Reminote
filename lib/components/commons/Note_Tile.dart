import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:study_app/components/widgets/Note_Home/Note_Content.dart';
import 'package:study_app/components/widgets/Note_Home/NoteDate.dart';
import 'package:study_app/components/widgets/Note_Home/NoteHeader.dart';
import 'package:study_app/models/Note.dart';
import 'package:study_app/utils/Color_helper.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final Function()? onTap;
  final Function()? onDelete;
  final Function()? onPin;

  const NoteTile({
    Key? key,
    required this.note,
    this.onTap,
    this.onDelete,
    this.onPin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color_helper().HexToColor(note.color ?? '#FFFFFF');
  
    return Card(
  color: backgroundColor,
  elevation: 5,
  shadowColor: backgroundColor.withOpacity(0.5), // dùng màu của note làm bóng
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(
      color: note.isPinned == true ? const Color.fromARGB(255, 255, 206, 46) : Colors.grey.shade300,
      width: note.isPinned == true ?  4: 1,
    ),
  ),
  child: InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NoteHeader(note: note, onDelete: onDelete, onPin: onPin),
          const SizedBox(height: 8),
          NoteContent(content: note.content),
          const SizedBox(height: 8),
          NoteDate(createdAt: note.createdAt),
        ],
      ),
    ),
  ),
);

  }
}
