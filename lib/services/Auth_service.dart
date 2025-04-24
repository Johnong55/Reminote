import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth error: ${e.code}');
      // Re-throw the exception so it can be caught by the UI
      throw e;
    } catch (e) {
      log('Unexpected error: $e');
      throw e;
    }
  }
  
  Future<UserCredential> signUp(String email, String password) async {
    try {
      
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth error: ${e.code}');
      // Re-throw the exception so it can be caught by the UI
      throw e;
    } catch (e) {
      log('Unexpected error: $e');
      throw e;
    }
  }
  
  Future<void> signOut() => _auth.signOut();

  Stream<User?> get authStateChange => _auth.authStateChanges();
}