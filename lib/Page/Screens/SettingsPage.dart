import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:study_app/providers/Completion_provider.dart';
import 'package:study_app/providers/Streak_provider.dart';
import 'package:study_app/providers/habit_provider.dart';

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
                    ClipOval(
                      child: SizedBox(
                      width: 100, // Set the desired width
                      height: 100, // Set the desired height
                      child: Lottie.asset("assets/lottie/avatar.json"),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Text(user.displayName ?? 'Không tên'),
                  Text(user.email ?? 'Không email'),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.logout, size: 40),
                    onPressed: () async {
                      final noteProvider = Provider.of<NoteProvider>(context, listen: false);
                      final habitProvider = Provider.of<HabitProvider>(context, listen: false);
                      final completeProvider = Provider.of<CompletionProvider>(context, listen: false);
                      final streakProvider = Provider.of<StreakProvider>(context, listen: false);
                      await habitProvider.deleteWhenLogout();
                      await completeProvider.clearCompletions();
                      // Gọi xóa ghi chú trước khi đăng xuất
                      await noteProvider.deleteWhenLogout();
                      await streakProvider.deleteStreakWhenLogout();
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
