import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ListStreak extends StatefulWidget {
  const ListStreak({super.key});

  @override
  State<ListStreak> createState() => _ListStreakState();
}

class _ListStreakState extends State<ListStreak> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
            SizedBox(
            height: 150,
            width: 150,
            child: Lottie.asset(
              'assets/lottie/fire.json',
              fit: BoxFit.contain,
             
            ),
            ),
          
          Container(
           padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: const Text(
              '5-day streak',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
       
          Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Text(
              'Keep it up!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          Container(
            
            
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(20),
            ),
            
            child: Padding(
              padding: const EdgeInsets.only(left: 29),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (index,context) => 
                GestureDetector(
                  onTap: () {
                    // Handle tap event here
                    log('Tapped on day $context');
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                       color: Color(0xFFFF4D00),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ) ,),
            ),
          ),
            Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(0, -3), // Negative offset to move shadow to the top
                  ),
                ],
              ),
              alignment: Alignment.center,
        
            ),
            )
        ],
      ),
    );
  }
}
