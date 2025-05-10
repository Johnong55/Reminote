import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/Page/Screens/ContactPage.dart';
import 'package:study_app/Page/Screens/NoteHome.dart';
import 'package:study_app/Page/Screens/HabitPage.dart';
import 'package:study_app/Page/Screens/SettingsPage.dart';
import 'package:study_app/components/widgets/CustomAppBar.dart';
import 'package:study_app/components/widgets/bottom_nav.dart';
import 'package:study_app/providers/habit_provider.dart';
import 'package:study_app/providers/note_provider.dart';

class Homepage extends StatefulWidget {
  final bool isLoggedIn;
  Homepage({super.key, required this.isLoggedIn});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isDrawerOpen = false;
  int pageNum = 0;

  final List<Widget> routes = [
    const Notehome(), 
    const Habitpage(), 
     const ContactPage(),
    const Settingspage()
  ];

  void toggleDrawer(bool value) {
    setState(() {
      isDrawerOpen = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: CustomAppBar(
        onDrawerToggle: toggleDrawer,
        isDrawerOpen: isDrawerOpen,
        currentPageIndex: pageNum,
      ),
      bottomNavigationBar: SafeArea(
        child: myBottomNav(
          onTabChange: (index) {
            if (pageNum != index) {
              setState(() {
                pageNum = index;
                
                if (index != 0) {
                  final noteProvider = Provider.of<NoteProvider>(context, listen: false);
                  if (noteProvider.searchQuery.isNotEmpty) {
                    noteProvider.searchNotes('');
                    noteProvider.clearSearch();
                  }
                }
              });
            }
          },
        ),
      ),
      body: IndexedStack(index: pageNum, children: routes),
    );
  }
}