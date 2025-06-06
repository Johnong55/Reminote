import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String text;
  const MessageTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicWidth(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              
              color: Colors.grey[200],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}