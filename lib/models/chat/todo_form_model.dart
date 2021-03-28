import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/chat_room.dart';
import 'package:flutter_chat_app/repositories/chat_room_repository.dart';

class TodoFormModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String documentId;
  String title;
  bool isLoading = false;

  TodoFormModel(ChatRoom todo) {
    if (todo == null) return;

    documentId = todo.documentId;
    // title = todo.title;
  }

  Future<void> addTodo(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    // await ChatRoomRepository().add(context, title);

    isLoading = false;
    notifyListeners();
  }

  Future<void> editTodo(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await ChatRoomRepository().edit(context, documentId, title);

    isLoading = false;
    notifyListeners();
  }
}
