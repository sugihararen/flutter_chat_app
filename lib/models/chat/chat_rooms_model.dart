import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/chat_room.dart';
import 'package:flutter_chat_app/repositories/auth_repository.dart';
import 'package:flutter_chat_app/repositories/chat_room_repository.dart';
import 'package:flutter_chat_app/repositories/user_repository.dart';

class ChatRoomsModel extends ChangeNotifier {
  List<ChatRoom> chatRooms = [];
  bool isLoading = false;

  Stream<QuerySnapshot> fetchChatRooms(BuildContext context) {
    return ChatRoomRepository().fetchChatRooms(context);
  }

  Future getUser(BuildContext context, userUids) async {
    return await UserRepository().getUser(context, userUids);
  }

  Future<void> deleteTodo(BuildContext context, String documentId) async {
    isLoading = true;
    notifyListeners();

    await ChatRoomRepository().delete(context, documentId);

    isLoading = false;
    notifyListeners();
  }

  Future signOut() async {
    await AuthRepository().signOut();
  }
}
