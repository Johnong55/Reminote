import 'package:flutter/material.dart';

class Contactpage extends StatelessWidget {
  const Contactpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 70,
       
        child: Center(
          child: ListView.builder(
            
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  'Contact Us',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
          'Email: contact@example.com',
        ),

    );

            },
          ),
        ),
      ),
    );
}
}
