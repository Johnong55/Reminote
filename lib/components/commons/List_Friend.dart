import 'package:flutter/material.dart';
import 'package:study_app/models/Online/ChatMessage.dart';

class ListFriend extends StatelessWidget {
  List<ChatMessage> chatmessages ;
   ListFriend({super.key, required this.chatmessages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
              Navigator.pushNamed(context,"/chat");
              
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
                title: Text('khaitran955@gmail.com', style: TextStyle( fontSize: 15),),
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
