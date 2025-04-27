import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_app/models/Note.dart';

class FirebaseService {
  final _collection = FirebaseFirestore.instance.collection('Notes');

  Future<void> uploadNote(Note note) async {
    if (note.ID == null || note.ID!.isEmpty) {
      note.ID = _collection.doc().id;
    }
    await _collection.doc(note.ID).set({
      'title': note.title,
      'content': note.content,
      'category': note.category,
      'color': note.color,
      'isPinned': note.isPinned ?? false,
      'createAt': note.createdAt ?? FieldValue.serverTimestamp(),
      'updateAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String id) async {
    await _collection.doc(id).delete();
  }

  Future<void> updateNote(Note note) async {
    if (note.ID == null) return;
    await _collection.doc(note.ID).update({
      'title': note.title,
      'content': note.content,
      'category': note.category,
      'color': note.color,
      'isPinned': note.isPinned ?? false,
      'updateAt': FieldValue.serverTimestamp(),
    });
  }

  // Optional: fetch all từ Firebase
  Future<List<Note>> fetchNotes() async {
    final snapshot = await _collection.orderBy("isPinned", descending: true).orderBy("createAt", descending: true).get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Note(
        title: data['title'],
        content: data['content'],
        category: data['category'],
        color: data['color'],
        isPinned: data['isPinned'],
        createdAt: (data['createAt'] as Timestamp?)?.toDate(),
        updatedAt: (data['updateAt'] as Timestamp?)?.toDate(),
      )..ID = doc.id;
    }).toList();
  }
}
