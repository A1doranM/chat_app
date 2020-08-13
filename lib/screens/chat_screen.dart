import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/LKW6Aw1kDA2aEGn76BF8/messages')
            .snapshots(),
        builder: (ctx, snapshot) {
          return ListView.builder(
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8.0),
              child: Text('This works'),
            ),
            itemCount: 2,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance.collection('chats').snapshots().listen((data) {
            print(data.documents);
          });
        },
      ),
    );
  }
}
