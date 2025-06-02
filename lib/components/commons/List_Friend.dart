import 'package:flutter/material.dart';

class ListFriend extends StatelessWidget {
  const ListFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
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
                title: Text('Friend $index'),
                subtitle: Text('Subtitle $index'),
                trailing: Padding(
                  padding: EdgeInsets.only(bottom: 10 ),
                  child: Column(
                    spacing: 3,
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
