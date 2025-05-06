import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';

class myBottomNav extends StatelessWidget {
  void Function(int)? onTabChange;
  myBottomNav({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

            text: ' N O T E',
            padding: EdgeInsets.all(10),
            textSize: 20,
            textColor: Colors.grey[900],
          ),
          GButton(
            icon: Icons.space_bar, // không dùng icon mặc định
            text: ' H A B I T',
            padding: EdgeInsets.all(10),
            textSize: 20,
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
              ],
            ),
          ),
          GButton(
            icon: Icons.space_bar, // không dùng icon mặc định
            text: ' C O L L A B',
            padding: EdgeInsets.all(10),
            textSize: 20,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Lottie.asset(
                    'assets/lottie/collaborator.json',
                    fit: BoxFit.contain,
                      repeat: false,
                   
                  ),
                ),
              ],
            ),
          ),
          GButton(
            icon: Icons.settings,
            text: 'U S E R',
            textSize: 20,
            textColor: Colors.grey[900],
            iconSize: 25.0,
            gap: 10.0,
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }
}
