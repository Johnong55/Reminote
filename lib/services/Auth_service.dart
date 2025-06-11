import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth error: ${e.code}');
      throw e;
    } catch (e) {
      log('Unexpected error: $e');
      throw e;
    }
  }

  Future<UserCredential> signUp(String email, String password,String displayName) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
        
      );
      credential.user?.updateDisplayName(displayName);

      final uid = credential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'name': displayName,// bạn có thể truyền vào nếu cần
        'imageUrl': '',
        'phone': '',
        'token': '',
        'tokenExpiration': 0,
        'longestStreak': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return credential;
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth error: ${e.code}');
      throw e;
    } catch (e) {
      log('Unexpected error: $e');
      throw e;
    }
  }

  Future<void> signOut() => _auth.signOut();

  Stream<User?> get authStateChange => _auth.authStateChanges();
}
