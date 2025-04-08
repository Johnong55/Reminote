import 'package:flutter/material.dart';

class Color_helper {
    Color HexToColor(String hexString) {
    try {
      final hexColor = hexString.replaceAll('#', '');
      return Color(int.parse('FF$hexColor', radix: 16));
    } catch (e) {
      return Colors.white;
    }
  }
 
}