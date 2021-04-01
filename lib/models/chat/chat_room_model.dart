import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/repositories/chat_room_repository.dart';

class ChatRoomModel extends ChangeNotifier {
  ChatRoomModel(chatRoomId) {
    chats = FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Stream<QuerySnapshot> chats;
  int currentChatLength = 0;
  TextEditingController messageEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void addMessage(BuildContext context, String chatRoomId) {
    ChatRoomRepository()
        .addMessage(context, messageEditingController.text, chatRoomId);
    messageEditingController.text = "";

    Future.delayed(
      Duration(milliseconds: 100),
      () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.ease,
          duration: Duration(milliseconds: 500),
        );
      },
    );
  }
}
