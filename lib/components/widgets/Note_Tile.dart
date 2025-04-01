import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_app/components/commons/confirm_dialog.dart';
import 'package:study_app/models/Note.dart';
 // Updated import

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
    // Format the date (if available)
    String formattedDate = 'No date';
    if (note.createdAt != null) {
      formattedDate = DateFormat('MMM dd, yyyy').format(note.createdAt!);
    }

    // Get a preview of the content
    String contentPreview = note.content != null && note.content!.isNotEmpty
        ? note.content!.length > 50
            ? '${note.content!.substring(0, 50)}...'
            : note.content!
        : 'No content';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: note.isPinned == true
              ? Colors.amber.shade300
              : Colors.grey.shade300,
          width: note.isPinned == true ? 2 : 1,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      note.title ?? 'Untitled Note',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          note.isPinned == true
                              ? Icons.push_pin
                              : Icons.push_pin_outlined,
                          color: note.isPinned == true ? Colors.amber : Colors.grey,
                        ),
                        onPressed: onPin,
                        tooltip: 'Pin note',
                        iconSize: 20,
                        splashRadius: 20,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          // Using the DeleteConfirmationDialog static method
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
                        iconSize: 20,
                        splashRadius: 20,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                contentPreview,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}