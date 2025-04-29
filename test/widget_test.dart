// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:study_app/main.dart';
import 'package:study_app/providers/Completion_provider.dart';
import 'package:study_app/providers/habit_provider.dart';
import 'package:study_app/providers/note_provider.dart';

void main() {
  
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
     final noteProvider = NoteProvider();
  final completionProvider = CompletionProvider();
  final habitProvider = HabitProvider();
  await completionProvider.intialize();
  await habitProvider.intialize();
  await noteProvider.initialize();
  await tester.pumpWidget(MyApp(noteProvider: noteProvider,habitProvider: habitProvider,completionProvider:completionProvider,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
