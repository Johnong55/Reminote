import 'package:flutter/material.dart';
import 'package:study_app/Online_Repository/Chat_Repository.dart';

import 'package:study_app/Page/Authentication/Auth_page.dart';
import 'package:study_app/Page/Screens/ChatPage.dart';

import 'package:study_app/Page/Screens/ContactPage.dart';
import 'package:study_app/Page/Screens/HabitPage.dart';

import 'package:study_app/Page/Screens/HomePage.dart';
import 'package:study_app/Page/Screens/NoteHome.dart';
import 'package:study_app/Page/Screens/SettingsPage.dart';
import 'package:study_app/Page/Screens/SignIn.dart';
import 'package:study_app/Page/Screens/SignUp.dart';
import 'package:study_app/config/app_theme.dart';
import 'package:study_app/providers/Chat_Provider.dart';
import 'package:study_app/providers/Completion_provider.dart';
import 'package:study_app/providers/Friend_Provider.dart';
import 'package:study_app/providers/Streak_provider.dart';
import 'package:study_app/providers/habit_provider.dart';
import 'package:study_app/providers/note_provider.dart';

import 'package:provider/provider.dart';  
import 'package:firebase_core/firebase_core.dart';
import 'package:study_app/services/Chat_service.dart';
import 'package:study_app/services/Friend_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final friendService = FriendService();
  final chatRepository = ChatRepository();
  final chatService= ChatService(repository: chatRepository);
  // Khởi tạo các provider
  final noteProvider = NoteProvider();
  final habitProvider = HabitProvider();
  final completionProvider = CompletionProvider();
  final streakProvider = StreakProvider();
  final friendProvider =  FriendProvider(friendService: friendService);
  final chatProvider = ChatProvider(chatService: chatService);

  // Khởi tạo dữ liệu
  await noteProvider.initialize();
  await habitProvider.intialize();
  completionProvider.intialize();

  runApp(MyApp(
    noteProvider: noteProvider,
    habitProvider: habitProvider,
    completionProvider: completionProvider,
    streakProvider: streakProvider,
    friendProvider:  friendProvider,
    chatProvider: chatProvider,
  ));
}

class MyApp extends StatelessWidget {
  final NoteProvider noteProvider;
  final HabitProvider habitProvider;
  final CompletionProvider completionProvider;
  final StreakProvider streakProvider;
  final FriendProvider friendProvider;
  final ChatProvider chatProvider;
  const MyApp({
    Key? key,
    required this.noteProvider,
    required this.habitProvider,
    required this.completionProvider,
    required this.streakProvider,
    required this.friendProvider,
    required this.chatProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Sử dụng provider đã khởi tạo thay vì tạo mới
        ChangeNotifierProvider.value(value: noteProvider),
        ChangeNotifierProvider.value(value: habitProvider),
        ChangeNotifierProvider.value(value: completionProvider),
        ChangeNotifierProvider.value(value: streakProvider),
        ChangeNotifierProvider.value(value: friendProvider),
        ChangeNotifierProvider.value(value: chatProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reminote',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: AuthPage(),
        navigatorKey: navigatorKey,
        routes: {
          '/home': (context) => Homepage(isLoggedIn: true),
          '/note': (context) => const Notehome(),
          '/settings': (context) => const Settingspage(),
          '/signup': (context) => const SignUpScreen(),
          '/login': (context) => const LoginScreen(),
          '/contact': (context) => const ContactPage(),
          '/habit': (context) => const Habitpage(),
          '/auth': (context) => const AuthPage(),
          '/chat':(context) => const ChatPage(),
        },
      ),
    );
  }
}