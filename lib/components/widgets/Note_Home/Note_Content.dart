import 'package:flutter/material.dart';

class NoteContent extends StatelessWidget {
  final String? content;

  const NoteContent({Key? key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String preview = content != null && content!.isNotEmpty
        ? (content!.length > 50 ? '${content!.substring(0, 50)}...' : content!)
        : 'No content';

    return Text(
      preview,
      style: TextStyle(
        fontSize: 18,
        color: Colors.grey.shade700,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
