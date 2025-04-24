import 'package:flutter/material.dart';
import 'package:study_app/components/commons/dialog/confirm_dialog.dart';
import 'package:study_app/components/widgets/Note_Home/NoteDate.dart';
import 'package:study_app/models/Note.dart';

class NoteHeader extends StatelessWidget {
  final Note note;
  final Function()? onDelete;
  final Function()? onPin;

  const NoteHeader({
    Key? key,
    required this.note,
    this.onDelete,
    this.onPin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            note.title ?? 'Untitled Note',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
              NoteDate(createdAt: note.updatedAt,)
          ],
        ),
      ],
    );
  }
}
