import 'package:flutter/material.dart';
import 'package:flutter_chat_app/repositories/chat_room_repository.dart';
import 'package:flutter_chat_app/repositories/user_repository.dart';

class UserSearchModel extends ChangeNotifier {
  TextEditingController searchEditingController = TextEditingController();
  bool isLoading = false;
  List<dynamic> users = [];

  Future<void> searchUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final snapshot = await UserRepository()
        .serchhUsers(context, searchEditingController.text);

    users = snapshot.docs;

    isLoading = false;
    notifyListeners();
  }

  Future<String> sendMessage(BuildContext context, String uid) async {
    return await ChatRoomRepository().addChatRoom(context, uid);
  }
}
