import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final chatDoc = snapshot.data.documents;
                  return ListView.builder(
                      reverse: true,
                      itemCount: chatDoc.length,
                      itemBuilder: (ctx, index) => MessageBubble(
                            key: ValueKey(chatDoc[index].documentID),
                            message: chatDoc[index]['text'],
                            username: chatDoc[index]['username'],
                            isMe: futureSnapshot.data.uid ==
                                chatDoc[index]['userId'],
                          ));
                }
              });
        });
  }
}
