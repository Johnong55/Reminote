import 'package:flutter/material.dart';
import 'package:study_app/Offline_Repository/Note_repository.dart';
import 'package:study_app/config/app_theme.dart';
import 'package:study_app/screens/HomePage.dart';
import 'package:study_app/screens/NoteDetailPage.dart';
import 'package:study_app/screens/NoteHome.dart';
import 'package:study_app/screens/SettingsPage.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  
  final noteRepository = Note_Repository();
  await noteRepository.initializeIsar();
  
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reminote',
      theme: lightMode,
      darkTheme: darkMode,
      home: Homepage(),
      routes: {
        '/home': (context) => const Homepage(),
        '/note': (context) => const Notehome(),
        '/settings': (context) => const Settingspage(),
        '/note_detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as int;
          return NoteDetailPage(noteID: args);  
        },
      },
    
    );
  }
}