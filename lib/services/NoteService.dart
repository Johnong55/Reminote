import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/Online_Repository/Note_repository_Online.dart';
import 'package:study_app/models/Offine/Note.dart';
import 'package:study_app/Offline_Repository/Note_repository_Offline.dart';

class NoteService {
  final NoteRepositoryOffline _offlineRepo = NoteRepositoryOffline();
  final NoteRepositoryOnline _onlineRepo = NoteRepositoryOnline();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Connectivity _connectivity = Connectivity();

  late final CollectionReference _cloudCollection;
  bool _isInitialized = false;
  List<Note> currentNotes = [];

  static final NoteService _instance = NoteService._internal();
  factory NoteService() => _instance;
  NoteService._internal();

  // -------------------- Initialization --------------------
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _offlineRepo.initializeIsar();

    final user = _auth.currentUser;
    _cloudCollection = FirebaseFirestore.instance.collection(
      user != null ? 'users/${user.uid}/Notes' : 'Notes',
    );

    if (user == null) {
      log("Warning: User not logged in - Firestore may reject operations");
    }

    _isInitialized = true;
  }

  bool _checkAuth() {
    final user = _auth.currentUser;
    if (user == null) {
      log("Error: User not logged in");
      return false;
    }
    return true;
  }

  Future<bool> _isNetworkAvailable() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  // -------------------- CRUD Operations --------------------
  Future<List<Note>> getAllNotes() async {
    await _offlineRepo.fetchNote();
    return _offlineRepo.currentNotes;
  }

  Future<void> createNote(Note note) async {
    note.ID = 'local_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
    note.userEmail = _auth.currentUser?.email;

    await _offlineRepo.createNote(note);

    if (await _isNetworkAvailable() && _onlineRepo.userId != null) {
      try {
        note.syncStatus = "Syncing";
        await _offlineRepo.updateNote(note);

        await _onlineRepo.addNotetoFireBase(note);

        note.syncStatus = "Synced";
        await _offlineRepo.updateNote(note);
        log("Note synced: ${note.ID}");
      } catch (e) {
        note.syncStatus = "unsynced";
        await _offlineRepo.updateNote(note);
        log("Sync failed: $e");
      }
    } else {
      note.syncStatus = "unsynced";
      await _offlineRepo.updateNote(note);
      log(_onlineRepo.userId == null ? "Login required to sync" : "No network. Will sync later.");
    }
  }

  Future<void> updateNote(Note note) async {
    note.updatedAt = DateTime.now();
    await _offlineRepo.updateNote(note);

    if (await _isNetworkAvailable() && _onlineRepo.userId != null) {
      try {
        note.syncStatus = "syncing";
        await _offlineRepo.updateNote(note);

        await _onlineRepo.updateNoteToFireBase(note);

        note.syncStatus = "synced";
        await _offlineRepo.updateNote(note);
      } catch (e) {
        note.syncStatus = "unsynced";
        await _offlineRepo.updateNote(note);
        log("Update sync failed: $e");
      }
    } else {
      note.syncStatus = "unsynced";
      await _offlineRepo.updateNote(note);
    }
  }

  Future<void> deleteNote(Note note) async {
    await _offlineRepo.deleteNote(note);

    if (note.ID != null && await _isNetworkAvailable() && _onlineRepo.userId != null) {
      try {
        await _onlineRepo.deleteNote(note.ID!);
      } catch (e) {
        log("Online delete failed: $e");
      }
    }
  }

  Future<List<Note>> searchByTitle(String title) async {
    return _offlineRepo.findByTitle(title);
  }

  Future<List<Note>> searchByText(String text) async {
    return _offlineRepo.findByString(text);
  }

  // -------------------- Sync Methods --------------------
  Future<void> syncAllNotes() async {
    if (!await _isNetworkAvailable() || _onlineRepo.userId == null) {
      log("Sync aborted: no network or user not logged in");
      return;
    }

    try {
      log("Starting sync...");

      final localNotes = await _offlineRepo.currentNotes;
      final onlineNotes = await _onlineRepo.getNotesByUserEmail();

      await _syncLocalToOnline(localNotes);
      await _syncOnlineToLocal(onlineNotes, localNotes);

      await _offlineRepo.fetchNote();
      log("Sync complete");
    } catch (e) {
      log("Sync error: $e");
    }
  }

  Future<void> _syncLocalToOnline(List<Note> localNotes) async {
    for (var note in localNotes) {
      if (note.syncStatus == "unsynced") {
        try {
          if (note.ID!.contains('local')) {
            await _onlineRepo.addNotetoFireBase(note);
          } else {
            await _onlineRepo.updateNoteToFireBase(note);
          }

          note.userEmail = _auth.currentUser?.email;
          note.syncStatus = "synced";
          await _offlineRepo.updateNote(note);
        } catch (e) {
          log("Local to online sync failed for ${note.ID}: $e");
        }
      }
    }
  }

  Future<void> _syncOnlineToLocal(List<Note> onlineNotes, List<Note> localNotes) async {
    final Map<String?, Note> localMap = { for (var note in localNotes) note.ID: note };

    for (var onlineNote in onlineNotes) {
      final localNote = localMap[onlineNote.ID];

      if (localNote == null) {
        onlineNote.syncStatus = "synced";
        await _offlineRepo.createNote(onlineNote);
        log("Downloaded new note: ${onlineNote.ID}");
      } else if (_isOnlineVersionNewer(onlineNote, localNote)) {
        await _updateLocalWithOnlineData(localNote, onlineNote);
        log("Updated local note from online: ${onlineNote.ID}");
      }
    }
  }

  bool _isOnlineVersionNewer(Note onlineNote, Note localNote) {
    return onlineNote.updatedAt != null &&
           localNote.updatedAt != null &&
           onlineNote.updatedAt!.isAfter(localNote.updatedAt!);
  }

  Future<void> _updateLocalWithOnlineData(Note localNote, Note onlineNote) async {
    localNote
      ..title = onlineNote.title
      ..content = onlineNote.content
      ..updatedAt = onlineNote.updatedAt
      ..isPinned = onlineNote.isPinned
      ..category = onlineNote.category
      ..color = onlineNote.color
      ..userEmail = onlineNote.userEmail
      ..syncStatus = "synced";

    await _offlineRepo.updateNote(localNote);
  }

  Future<void> pullFromFirebase() async {
    if (!await _isNetworkAvailable() || _onlineRepo.userId == null) return;

    try {
      final onlineNotes = await _onlineRepo.getNotesByUserEmail();

      for (var note in onlineNotes) {
        note.syncStatus = "synced";
        await _offlineRepo.updateNote(note);
      }

      await _offlineRepo.fetchNote();
    } catch (e) {
      log("Error pulling from Firebase: $e");
    }
  }

  // -------------------- Utilities --------------------
  Future<void> togglePin(Note note) async {
    note.isPinned = !(note.isPinned ?? false);
    await updateNote(note);
  }

  Future<void> clearLocalNotesWhenLogout() async {
    final userEmail = _auth.currentUser?.email;

    if (userEmail != null) {
      final notesToDelete = await _offlineRepo.findByEmail(userEmail);
      log("Deleting ${notesToDelete.length} local notes");

      for (var note in notesToDelete) {
        await _offlineRepo.deleteNote(note);
      }
    } else {
      log("Logout failed: user email is null");
    }
  }
}
