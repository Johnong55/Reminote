import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/Page/Screens/NoteHome.dart';
import 'package:study_app/Page/Screens/HabitPage.dart';
import 'package:study_app/Page/Screens/SettingsPage.dart';
import 'package:study_app/components/commons/bottom_nav.dart';
import 'package:study_app/providers/note_provider.dart';

class Homepage extends StatefulWidget {
   final bool isLoggedIn;
   Homepage({super.key, required this.isLoggedIn});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int pageNum = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final List<Widget> routes = [const Notehome(), const Habitpage(), const Settingspage()];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final noteProvider = Provider.of<NoteProvider>(context, listen: false);
      _searchController.text = noteProvider.searchQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _isSearching
              ? AppBar(
                
                  key: const ValueKey('searchAppBar'),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        _isSearching = false;
                        noteProvider.clearSearch();
                        _searchController.clear();
                      });
                    },
                  ),
                  title: TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: textTheme.bodyLarge, // Using theme text style
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm...',
                      hintStyle: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (pageNum == 0) {
                        noteProvider.searchNotes(value);
                     
                      }
                    },
                    onSubmitted: (value) {
                      noteProvider.searchNotes(value);
               
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  actions: [
                    
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        noteProvider.clearSearch();
                        _searchController.clear();
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  
                  ],
                )
              : AppBar(
                  key: const ValueKey('normalAppBar'),
                  title: Text(
                    'REMINOTE',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.sync),
                        
                        onPressed: () {
                          noteProvider.syncNotes();
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        tooltip: 'Tìm kiếm',
                        onPressed: () {
                          setState(() {
                            _isSearching = true;
                          });
                        },
                      ),
                    ),
                    // Empty container removed as it wasn't serving any purpose
                  ],
                ),
        ),
      ),
      bottomNavigationBar: myBottomNav(
        onTabChange: (index) {
          if (pageNum != index) {
            setState(() {
              pageNum = index;
              
              if (index != 0 && noteProvider.searchQuery.isNotEmpty) {
                _searchController.clear();
                noteProvider.searchNotes('');
                noteProvider.clearSearch();
              }
            });
          }
        },
      ),
      body: IndexedStack(index: pageNum, children: routes),
    );
  }
}