import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                itemBuilder: (ctx, index) => Text(chatDoc[index]['text']));
          }
        });
  }
}
