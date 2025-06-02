 import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:study_app/components/commons/List_Friend.dart';
import 'package:study_app/components/widgets/CustomSelectedContainer.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String selectedTab = "Contact";

  void onTabChange(String value) {
    setState(() {
      selectedTab = value;
    });

    switch (value) {
      case "Contact":
        log("Contact");
        break;
      case "Feedback":
        log("Feedback");
        break;
      default:
        log("Default");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0.5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Customselectedcontainer(
                  title: "F R I E N D S",
                  isSelect: selectedTab == "Contact",
                  leftorRight: true,
                  onTap: () => onTabChange("Contact"),
                ),
                Customselectedcontainer(
                  title: "G R O U P S",
                  isSelect: selectedTab == "Feedback",
                  leftorRight: false,
                  onTap: () => onTabChange("Feedback"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: ListFriend()
            ),
          ),
        ],
      ),
    );
  }
}
