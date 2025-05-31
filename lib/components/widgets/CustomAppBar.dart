import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/providers/Completion_provider.dart';
import 'package:study_app/providers/Streak_provider.dart';
import 'package:study_app/providers/note_provider.dart';
import 'package:study_app/providers/habit_provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(bool) onDrawerToggle;
  final bool isDrawerOpen;
  final int currentPageIndex;

  const CustomAppBar({
    Key? key,
    required this.onDrawerToggle,
    required this.isDrawerOpen,
    required this.currentPageIndex,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

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
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    final completedProvider = Provider.of<CompletionProvider>(context, listen: false);
    final streakProvider = Provider.of<StreakProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child:
          _isSearching
              ? AppBar(
                key: const ValueKey('searchAppBar'),
                backgroundColor: colorScheme.surface,
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
                  style: textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm...',
                    hintStyle: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (widget.currentPageIndex == 0) {
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
                backgroundColor: colorScheme.surface,
                title: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'REMINOTE',
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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
                      onPressed: () async {
                       await noteProvider.syncNotes();
                       await habitProvider.pullHabitWhenLogin();
                      await  completedProvider.getAllCompletionOnline();
                         await  streakProvider.getStreakFromFireBase();
                        await completedProvider.wereCompletedonDate() ? streakProvider.completeToday() : log("Today is not completed"); 
                        
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
                ],
              ),
    );
  }
}
