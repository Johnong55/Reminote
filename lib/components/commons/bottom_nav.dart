import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class myBottomNav extends StatelessWidget {
  void Function(int)? onTabChange;
  myBottomNav({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GNav(
        mainAxisAlignment: MainAxisAlignment.center,
        color: Colors.grey[400],
        activeColor: Colors.grey[900],
        tabActiveBorder: Border.all(color: Colors.grey.shade200),
        tabBackgroundColor: Colors.grey.shade200,
        tabBorderRadius: 18,
        onTabChange: (value) => onTabChange!(value),
        tabs: [
          GButton(
            icon: Icons.book,
            text: 'N O T E',
            textColor: Colors.grey[900],
            iconSize: 25.0,
            gap: 10.0,
          ),
          GButton(
            icon: Icons.task_rounded,
            text: 'R E M I N D E R',
            textColor: Colors.grey[900],
            iconSize: 25.0,
            gap: 10.0,
          ),
         
        ],
      ),
    );
  }
}
