import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteDate extends StatelessWidget {
  final DateTime? createdAt;

  const NoteDate({Key? key, this.createdAt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateText = createdAt != null
        ? DateFormat('MMM dd, yyyy').format(createdAt!)
        : 'No date';

    return Text(
      dateText,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade500,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
