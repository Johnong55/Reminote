// File: lib/components/widgets/drawer_background.dart

import 'package:flutter/material.dart';

class DrawerBackground extends StatelessWidget {
  final bool isDrawerOpen;
  final VoidCallback onTap;
  final Duration animationDuration;

  const DrawerBackground({
    Key? key,
    required this.isDrawerOpen,
    required this.onTap,
    this.animationDuration = const Duration(milliseconds: 250),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isDrawerOpen ? 1.0 : 0.0,
      duration: animationDuration,
      child: isDrawerOpen
          ? GestureDetector(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
              ),
            )
          : Container(),
    );
  }
}