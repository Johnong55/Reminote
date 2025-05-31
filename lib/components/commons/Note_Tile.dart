

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:study_app/components/commons/dialog/confirm_dialog.dart';
import 'package:study_app/components/widgets/Note_Home/Note_Content.dart';

import 'package:study_app/components/widgets/Note_Home/NoteHeader.dart';
import 'package:study_app/models/Offine/Note.dart';
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
      shadowColor: backgroundColor.withOpacity(
        0.5,
      ), // dùng màu của note làm bóng
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              note.isPinned == true
                  ? const Color.fromARGB(255, 255, 206, 46)
                  : const Color.fromARGB(255, 200, 200, 200),
          width: note.isPinned == true ? 4 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                backgroundColor: Theme.of(context).colorScheme.error,
                icon: Icons.delete,
                label: 'delete',
                borderRadius: BorderRadius.circular(12),
                onPressed:
                    (context) => {
                      DeleteConfirmationDialog.show(
                        context: context,
                        title: 'Xác nhận xóa',
                        content: 'Bạn có chắc chắn muốn xóa ghi chú này không?',
                        onConfirm: () {
                          if (onDelete != null) {
                            onDelete!();
                          }
                        },
                      ),
                    },
              ),
            ],
          ),
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                icon: Icons.push_pin_sharp,
                label: 'pinNote',
                autoClose: true,
                borderRadius: BorderRadius.circular(12),
                onPressed: (context) {
                  if (onPin != null) {
                    onPin!();
                  }
                },
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NoteHeader(note: note, onDelete: onDelete, onPin: onPin),
                  const SizedBox(height: 8),
                  NoteContent(content: note.content),
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
