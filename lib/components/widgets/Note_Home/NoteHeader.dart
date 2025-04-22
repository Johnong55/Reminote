import 'package:flutter/material.dart';
import 'package:study_app/components/commons/dialog/confirm_dialog.dart';
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                note.isPinned == true ? Icons.push_pin : Icons.push_pin_outlined,
                color: note.isPinned == true ? Colors.amber : Colors.grey,
              ),
              onPressed: onPin,
              tooltip: 'Pin note',
              iconSize: 25,
              splashRadius: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                DeleteConfirmationDialog.show(
                  context: context,
                  title: 'Xác nhận xóa',
                  content: 'Bạn có chắc chắn muốn xóa ghi chú này không?',
                  onConfirm: () {
                    if (onDelete != null) {
                      onDelete!();
                    }
                  },
                );
              },
              tooltip: 'Delete note',
              iconSize: 25,
              splashRadius: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }
}
