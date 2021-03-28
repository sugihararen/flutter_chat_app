import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_repository.dart';

class ChatRoomRepository {
  Stream<QuerySnapshot> fetchChatRooms(BuildContext context) {
    final String uid =
        Provider.of<AuthRepository>(context, listen: false).currentUser.uid;
    final Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
        .collection('chatRooms')
        .where('userUids', arrayContains: uid)
        .snapshots();

    return snapshots;
  }

  Future<String> addChatRoom(BuildContext context, String uid) async {
    final String currentUserUid =
        Provider.of<AuthRepository>(context, listen: false).currentUser.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("chatRooms")
        .where('userUids', arrayContainsAny: [currentUserUid, uid]).get();

    if (querySnapshot.docs.length >= 1) return querySnapshot.docs[0].id;

    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("chatRooms").add({
      'userUids': [currentUserUid, uid]
    });

    return documentReference.id;
  }

  Future addMessage(
      BuildContext context, String message, String chatRoomId) async {
    final String uid =
        Provider.of<AuthRepository>(context, listen: false).currentUser.uid;

    Map<String, dynamic> data = {
      "sendBy": uid,
      "message": message,
      'time': DateTime.now().millisecondsSinceEpoch,
    };

    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .add(data);
  }

  Future<void> edit(
      BuildContext context, String documentId, String title) async {
    final String uid =
        Provider.of<AuthRepository>(context, listen: false).currentUser.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(documentId)
        .update(
      {
        'title': title,
        'updatedAt': Timestamp.now(),
      },
    );
  }

  Future<void> delete(BuildContext context, String documentId) async {
    final String uid =
        Provider.of<AuthRepository>(context, listen: false).currentUser.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(documentId)
        .delete();
  }
}
