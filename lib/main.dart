import 'package:flutter/material.dart';
import 'package:study_app/API/firebase_api.dart';
import 'package:study_app/Page/Authentication/Auth_page.dart';
import 'package:study_app/Page/Screens/ContactPage.dart';
import 'package:study_app/Page/Screens/HabitPage.dart';
import 'package:study_app/Page/Screens/HeatMapCalendar.dart';
import 'package:study_app/Page/Screens/HomePage.dart';
import 'package:study_app/Page/Screens/NoteHome.dart';
import 'package:study_app/Page/Screens/SettingsPage.dart';
import 'package:study_app/Page/Screens/SignIn.dart';
import 'package:study_app/Page/Screens/SignUp.dart';
import 'package:study_app/config/app_theme.dart';
import 'package:study_app/providers/Completion_provider.dart';
import 'package:study_app/providers/Streak_provider.dart';
import 'package:study_app/providers/habit_provider.dart';
import 'package:study_app/providers/note_provider.dart';


import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

  final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  // Đảm bảo Flutter đã được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();



  // Khởi tạo NoteProvider và chờ nó hoàn tất khởi tạo
  final noteProvider = NoteProvider();
  final habitProvider  = HabitProvider();
    final CompletionProvider completionProvider = CompletionProvider();  
    final StreakProvider streakProvider = StreakProvider();
   
    completionProvider.intialize();
  await noteProvider.initialize(); // Phương thức này sẽ khởi tạo Isar và tải notes
  await habitProvider.intialize();
  runApp(MyApp(noteProvider: noteProvider,habitProvider: habitProvider,completionProvider: completionProvider,streakProvider: streakProvider,));
}

class MyApp extends StatelessWidget {
  final NoteProvider noteProvider;  final HabitProvider habitProvider;
  final CompletionProvider completionProvider;
  final StreakProvider streakProvider;
  const MyApp({Key? key, required this.noteProvider , required this.habitProvider, required this.completionProvider,required this.streakProvider}) : super(key: key);
@override
Widget build(BuildContext context) {
  return MultiProvider(
    providers: [
      // Sử dụng provider đã khởi tạo thay vì tạo mới
      ChangeNotifierProvider.value(value: noteProvider),
      ChangeNotifierProvider.value(value: habitProvider),
      ChangeNotifierProvider.value(value: completionProvider),
      ChangeNotifierProvider.value(value: streakProvider),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reminote',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: AuthPage(),
      navigatorKey: navigatorKey,
      routes: {
        '/home': (context) => Homepage(isLoggedIn: true ,),
        '/note': (context) => const Notehome(),
        '/settings': (context) => const Settingspage(),
        '/signup': (context) => const SignUpScreen(),
        '/login' : (context) => const LoginScreen(),
        '/contact': (context) => const ContactPage(),
        '/habit': (context) => const Habitpage(),
        '/auth': (context) => const AuthPage(),
      
      },
    ),
  );
}
}