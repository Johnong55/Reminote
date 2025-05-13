import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/models/Offine/Note.dart';

class NoteRepositoryOnline {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  String? get userId => _auth.currentUser?.uid;
  Future<List<Note>> getNotesByUserEmail() async {
    try {

      if (this.userId == null) {
        throw Exception(" User haven't log in ");
      }
    

      final notesSnapshot =
          await _firestore
              .collection("users")
              .doc(userId)
              .collection("Notes")
              .get();

      return notesSnapshot.docs.map((doc) {
        final data = doc.data();
        return Note(
          title: data['title'],
          content: data['content'],
          createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
          updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
          isPinned: data['isPinned'],
          category: data['category'],
          color: data['color'],
          userEmail: data['userEmail'],
        
        )..ID = doc.id;
      }).toList();
    } catch (e) {
      log("Lỗi khi lấy notes: $e");
      return [];
    }
  }
   // Add Note
  Future<void> addNotetoFireBase(Note note) async {
    try {
      if (userId == null) throw Exception("Chưa đăng nhập");

      final noteRef = await _firestore
          .collection("users")
          .doc(userId)
          .collection("Notes")
          .add({
        'title': note.title,
        'content': note.content,
        'createdAt': note.createdAt ?? DateTime.now(),
        'updatedAt': note.updatedAt ?? DateTime.now(),
        'isPinned': note.isPinned ?? false,
        'category': note.category,
        'color': note.color,
        'userEmail': _auth.currentUser?.email,
        'syncStatus': note.syncStatus ?? "synced",
      });

      note.ID = noteRef.id;
    } catch (e) {
      log("Lỗi khi thêm note: $e");
    }
  }
  Future<void> updateNoteToFireBase(Note note) async{
    try{
      if(userId == null || note.ID == null )
      {
        throw Exception("lack of information");
      }
      await _firestore
      .collection("users")
      .doc(userId)
      .collection("Notes")
      .doc(note.ID!)
      .update({
        'title': note.title,
         'content': note.content,
        'createdAt': note.createdAt ?? DateTime.now(),
        'updatedAt': note.updatedAt ?? DateTime.now(),
        'isPinned': note.isPinned ?? false,
        'category': note.category,
        'color': note.color,
        'userEmail': note.userEmail,
        'syncStatus': note.syncStatus ?? "synced",
      });
    } 
    catch (e) {
      log("error when update note");
    }
  }
   Future<void> deleteNote(String noteId) async {
    try {
      if (userId == null) throw Exception("Chưa đăng nhập");

      await _firestore
          .collection("users")
          .doc(userId)
          .collection("Notes")
          .doc(noteId)
          .delete();
    } catch (e) {
      print("Lỗi khi xoá note: $e");
    }
  }

}
