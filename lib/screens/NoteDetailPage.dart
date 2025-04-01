import 'package:flutter/material.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteID;
  const NoteDetailPage({super.key,required this.noteID});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}