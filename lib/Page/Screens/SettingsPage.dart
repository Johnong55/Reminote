import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/providers/note_provider.dart';
import 'package:study_app/services/Auth_service.dart';

class Settingspage extends StatelessWidget {
  const Settingspage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (user == null) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Đăng nhập'),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                    
                  ),
                  const SizedBox(height: 10),
                  Text(user.displayName ?? 'Không tên'),
                  Text(user.email ?? 'Không email'),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.logout, size: 40),
                    onPressed: () async {
                      final noteProvider = Provider.of<NoteProvider>(context, listen: false);

                      // Gọi xóa ghi chú trước khi đăng xuất
                      await noteProvider.deleteWhenLogout();

                      // Sau đó đăng xuất
                      await _auth.signOut();
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
