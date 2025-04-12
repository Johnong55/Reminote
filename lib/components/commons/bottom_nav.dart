import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';

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
            icon: Icons.sticky_note_2_outlined,
            text: 'N O T E',
            textSize : 30,
            textColor: Colors.grey[900],

          ),
          GButton(
            icon: Icons.space_bar, // không dùng icon mặc định
            text: 'R E M I N D E R',
            textSize: 30,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Lottie.asset(
                    'assets/lottie/fire.json',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 5),
                
              ],
            ),
          ),

          GButton(
            icon: Icons.settings,
            text: 'S E T T I N G S',
            textColor: Colors.grey[900],
            iconSize: 25.0,
            gap: 10.0,
          ),
        ],
      ),
    );
  }
}
