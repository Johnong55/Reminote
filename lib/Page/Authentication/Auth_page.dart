import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_app/Page/Screens/HomePage.dart';
import 'package:study_app/Page/Screens/SignIn.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final isLoggedIn = user != null;
      
        return Homepage(isLoggedIn: isLoggedIn); // truyền cờ vào homepage
      },
    );
  }
}
