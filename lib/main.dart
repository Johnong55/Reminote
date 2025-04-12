import 'package:flutter/material.dart';
import 'package:study_app/Offline_Repository/Note_repository.dart';
import 'package:study_app/config/app_theme.dart';
import 'package:study_app/providers/note_provider.dart';
import 'package:study_app/screens/HomePage.dart';
import 'package:study_app/screens/NoteDetailPage.dart';
import 'package:study_app/screens/NoteHome.dart';
import 'package:study_app/screens/SettingsPage.dart';
import 'package:provider/provider.dart';

void main() async {
  // Đảm bảo Flutter đã được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khởi tạo NoteProvider và chờ nó hoàn tất khởi tạo
  final noteProvider = NoteProvider();
  await noteProvider.initialize(); // Phương thức này sẽ khởi tạo Isar và tải notes
  
  runApp(MyApp(noteProvider: noteProvider));
}

class MyApp extends StatelessWidget {
  final NoteProvider noteProvider;
  
  const MyApp({Key? key, required this.noteProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Sử dụng provider đã khởi tạo thay vì tạo mới
        ChangeNotifierProvider.value(value: noteProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reminote',
        theme: minimalistLightMode,
        darkTheme:minimalistDarkMode ,
        home: Homepage(),
        routes: {
          '/home': (context) => const Homepage(),
          '/note': (context) => const Notehome(),
          '/settings': (context) => const Settingspage(),
        },
      ),
    );
  }
}