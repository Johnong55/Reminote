// Removed unused import

import 'package:flutter/material.dart';
class Customselectedcontainer extends StatelessWidget {
  final String title;
  final bool isSelect;
  final bool leftorRight;
  final VoidCallback? onTap;

  const Customselectedcontainer({
    super.key,
    required this.title,
    required this.isSelect,
    required this.leftorRight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelect ? Color.fromARGB(255, 247, 223, 216) : Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.horizontal(
            left: leftorRight ? const Radius.circular(20) : Radius.zero,
            right: !leftorRight ? const Radius.circular(20) : Radius.zero,
          ),
          border: Border.all(
            color: Colors.black
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelect ? Colors.grey.shade800 : Colors.grey.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
