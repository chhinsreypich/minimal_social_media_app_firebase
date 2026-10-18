/*
this database store post that users have published in the app. 
it is stored in a collection called "posts" in firebaes

each post contain: 
- a message
- email of user
- timestamp

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      "UserEmail": user!.email,
      "PostMessage": message,
      "Timestamp": Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('Timestamp', descending: true)
        .snapshots();

    return postsStream;
  }
}
