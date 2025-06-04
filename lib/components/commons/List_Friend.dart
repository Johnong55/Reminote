import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:study_app/models/Online/ChatMessage.dart';
import 'package:study_app/models/Online/Friends.dart';

class ListFriend extends StatelessWidget {
  List<Friend> friends; 
    ListFriend({super.key , required this.friends});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
          log("chat with ${friends[index].displayName}");
          },
          child: Padding(
          
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange[100] ,
                borderRadius: BorderRadius.circular(10)
              ),
              child: ListTile(
                
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Image.asset("assets/images/png/account.png")
                ),
                title: Text('${friends[index].displayName}', style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold),),
                subtitle: Text('Subtitle $index',style: TextStyle(fontSize: 12),),
                trailing: Padding(
                  padding: EdgeInsets.only(bottom: 10 , top: 5),
                  child: Column(
                    spacing: 5,
                    children: [
                      Text("Just Now"),
                      Container(
                        
                        alignment: Alignment.center,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                        height: 20,
                        width: 20,
                        child: Text("3"),
                      ) 
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
