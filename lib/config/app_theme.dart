import 'package:flutter/material.dart';

ThemeData lightMode  = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade400,
    
  )
) ;
ThemeData darkMode  = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background:  Color.fromARGB(255, 17, 17, 17)
    
  )
) ;