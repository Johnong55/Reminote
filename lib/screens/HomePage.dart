import 'package:flutter/material.dart';
import 'package:study_app/components/commons/bottom_nav.dart';
import 'package:study_app/screens/NoteHome.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _isSearching 
            ? AppBar(
                key: const ValueKey('searchAppBar'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                    });
                  },
                ),
                title: TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                      print(value);
                  },
                ),
              )
            : AppBar(
                key: const ValueKey('normalAppBar'),
        
                title: const Text(
                  'REMINOTE',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _isSearching = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
        ),
      ),
      bottomNavigationBar: myBottomNav(
        onTabChange: (index) {
          // Xử lý thay đổi tab
        },
      ),
      body: Notehome(), // Gọi widget Notehome ở đây
    );
  }
}