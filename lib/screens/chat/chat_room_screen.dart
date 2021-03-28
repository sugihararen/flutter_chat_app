import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/chat/chat_room_model.dart';
import 'package:flutter_chat_app/repositories/auth_repository.dart';
import 'package:flutter_chat_app/widget/chat/message_tile.dart';
import 'package:provider/provider.dart';

class ChatRoomScreen extends StatelessWidget {
  final String chatRoomId;
  ChatRoomScreen(this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatRoomModel>(
      create: (_) => ChatRoomModel(chatRoomId),
      child: Consumer<ChatRoomModel>(
        builder:
            (BuildContext context, ChatRoomModel chatRoomModel, Widget child) {
          return Scaffold(
            body: Container(
              child: Stack(
                children: [
                  StreamBuilder(
                    stream: chatRoomModel.chats,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 80),
                          child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return MessageTile(
                                message: snapshot.data.docs[index]["message"],
                                sendByMe: Provider.of<AuthRepository>(context,
                                            listen: false)
                                        .currentUser
                                        .uid ==
                                    snapshot.data.docs[index]["sendBy"],
                              );
                            },
                          ),
                        );
                      }

                      return Container();
                    },
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      color: Color(0x54FFFFFF),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller:
                                  chatRoomModel.messageEditingController,
                              decoration: InputDecoration(
                                hintText: "Message ...",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          IconButton(
                            icon: Icon(Icons.send_sharp),
                            onPressed: () => chatRoomModel.addMessage(
                              context,
                              chatRoomId,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
