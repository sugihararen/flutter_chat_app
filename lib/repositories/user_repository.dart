import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

class UserRepository {
  Future<QuerySnapshot> serchhUsers(
      BuildContext context, String userName) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .orderBy('name')
        .startAt([userName]).endAt([userName + '\uf8ff']).get();
  }

  Future<DocumentSnapshot> getUser(BuildContext context, userUids) {
    final String currentUid =
        Provider.of<AuthRepository>(context, listen: false).currentUser.uid;
    final searchUid = userUids.firstWhere((uid) => uid != currentUid);

    return FirebaseFirestore.instance.collection("users").doc(searchUid).get();
  }
}
