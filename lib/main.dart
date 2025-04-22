import 'package:flutter/material.dart';
import 'package:study_app/Offline_Repository/Note_repository_Offline.dart';
import 'package:study_app/Page/Authentication/Auth_page.dart';
import 'package:study_app/Page/Screens/HomePage.dart';
import 'package:study_app/Page/Screens/NoteHome.dart';
import 'package:study_app/Page/Screens/SettingsPage.dart';
import 'package:study_app/Page/Screens/SignIn.dart';
import 'package:study_app/Page/Screens/SignUp.dart';
import 'package:study_app/config/app_theme.dart';
import 'package:study_app/providers/note_provider.dart';


import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Đảm bảo Flutter đã được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: AuthPage(),
      routes: {
        '/home': (context) => Homepage(isLoggedIn: true ,),
        '/note': (context) => const Notehome(),
        '/settings': (context) => const Settingspage(),
        '/signup': (context) => const SignUpScreen(),
        '/login' : (context) => const LoginScreen()
      },
    ),
  );
}
}