import 'package:flutter/material.dart';

class ListFriend extends StatelessWidget {
  const ListFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              'A$index',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text('Friend $index'),
          subtitle: Text('Subtitle $index'),
          trailing: IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // Handle message button press
            },
          ),
        );
      },
    );
  }
}