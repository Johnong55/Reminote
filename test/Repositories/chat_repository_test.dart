// test/Online_Repository/chat_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mocktail/mocktail.dart';

import 'package:study_app/Online_Repository/Chat_Repository.dart';

// Mock classes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUser extends Mock implements User {}
class MockDatabaseReference extends Mock implements DatabaseReference {}
class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
  late MockDatabaseReference mockRef;
  late MockFirebaseDatabase mockDatabase;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockRef = MockDatabaseReference();
    mockDatabase = MockFirebaseDatabase();

    registerFallbackValue(Uri()); // chỉ cần nếu dùng Uri
  });

  test('should initialize ref with correct path when user is logged in', () {
    when(() => mockUser.email).thenReturn('test@example.com');
    when(() => mockAuth.currentUser).thenReturn(mockUser);
    when(() => mockDatabase.ref('users/test@example.com')).thenReturn(mockRef);

    final repo = ChatRepository(auth: mockAuth, database: mockDatabase);

    expect(repo.ref, mockRef);
  });

  test('sendMessage should call ref.set with correct data', () async {
    when(() => mockUser.email).thenReturn('opponent@example.com');

    final mockCurrentUser = MockUser();
    when(() => mockCurrentUser.email).thenReturn('me@example.com');

    when(() => mockAuth.currentUser).thenReturn(mockCurrentUser);
    when(() => mockDatabase.ref(any())).thenReturn(mockRef);
    when(() => mockRef.set(any())).thenAnswer((_) async => {});

    final repo = ChatRepository(auth: mockAuth, database: mockDatabase);
    await repo.sendMessage('Hello', mockUser);

    verify(() => mockRef.set(
      any(
        that: predicate<Map>((data) =>
            data['username'] == 'opponent@example.com' &&
            data['message'] == 'Hello' &&
            data.containsKey('time')),
      ),
    )).called(1);
  });
}
