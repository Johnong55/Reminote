import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:isar/isar.dart';

part 'Completions.g.dart';

@Collection()
class Completions {
  // Isar auto-increment ID for local storage
  Id id = Isar.autoIncrement;

  // Cloud ID (Firestore document ID)
  String? ID;

  // Reference to the habit this completion is for
  int? habitID;

  // Whether the habit is completed or not
  @Index()
  bool? isCompleted;

  // The date when the habit was completed
  @Index()
  DateTime? dateCompleted;

  // User email for cloud sync
  String? userEmail;

  // Last modified timestamp for conflict resolution
  DateTime? lastModified;

  // Flag to track sync status
  @Index()
  bool needsSync = false;

  Completions({
    this.habitID,
    this.isCompleted,
    this.dateCompleted,
    this.userEmail,
    this.ID,
    this.lastModified,
    this.needsSync = false,
  });

  @override
  String toString() {
    return "Completion: habitID=$habitID, "
        "dateCompleted=$dateCompleted, "
        "isCompleted=$isCompleted, "
        "needsSync=$needsSync"
        "ID = $ID";
  }

  // Create from Firestore document
  factory Completions.fromFirestore(firestore.DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Completions(
      ID: doc.id,
      habitID: data['habitID'] as int?,
      isCompleted: data['completed'] as bool?,
      dateCompleted: (data['completedDate'] as firestore.Timestamp?)?.toDate(),
      userEmail: data['userEmail'] as String?,
      lastModified:
          (data['lastModified'] as firestore.Timestamp?)?.toDate() ?? DateTime.now(),
      needsSync: false, // It came from the cloud, so it's synced
    );
  }

  // Create from local JSON (for future use with persistent queue)
  static Completions fromJson(Map<String, dynamic> json) {
    return Completions(
      ID: json['ID'] as String?,
      habitID: json['habitID'] as int?,
      isCompleted: json['completed'] as bool?,
      dateCompleted:
          json['completedDate'] is firestore.Timestamp
              ? (json['completedDate'] as firestore.Timestamp).toDate()
              : json['completedDate'] != null
              ? DateTime.parse(json['completedDate'].toString())
              : null,
      userEmail: json['userEmail'] as String?,
      lastModified:
          json['lastModified'] != null
              ? DateTime.parse(json['lastModified'].toString())
              : DateTime.now(),
      needsSync: json['needsSync'] as bool? ?? false,
    );
  }

  // Convert to JSON for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'habitID': habitID,
      'completed': isCompleted,
      'completedDate': dateCompleted,
      'userEmail': userEmail,
      'lastModified': firestore.FieldValue.serverTimestamp(),
    };
  }

  // Convert to JSON for local storage
  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'habitID': habitID,
      'isCompleted': isCompleted,
      'dateCompleted': dateCompleted?.toIso8601String(),
      'userEmail': userEmail,
      'lastModified': lastModified?.toIso8601String(),
      'needsSync': needsSync,
    };
  }

  // Create a copy with updated fields
  Completions copyWith({
    String? ID,
    int? habitID,
    bool? isCompleted,
    DateTime? dateCompleted,
    String? userEmail,
    DateTime? lastModified,
    bool? needsSync,
  }) {
    return Completions(
      ID: ID ?? this.ID,
      habitID: habitID ?? this.habitID,
      isCompleted: isCompleted ?? this.isCompleted,
      dateCompleted: dateCompleted ?? this.dateCompleted,
      userEmail: userEmail ?? this.userEmail,
      lastModified: lastModified ?? this.lastModified,
      needsSync: needsSync ?? this.needsSync,
    );
  }

  
  
}
