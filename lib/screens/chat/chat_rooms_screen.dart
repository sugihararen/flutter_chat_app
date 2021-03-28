import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/chat/chat_rooms_model.dart';
import 'package:flutter_chat_app/widget/chat/chat_room_tile.dart';
import 'package:flutter_chat_app/widget/loading/overlay_loading.dart';
import 'package:provider/provider.dart';

class ChatRoomsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatRoomsModel>(
      create: (_) => ChatRoomsModel(),
      child: Consumer<ChatRoomsModel>(
        builder: (BuildContext context, ChatRoomsModel chatRoomsModel,
            Widget child) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Chat Rooms',
                    style: TextStyle(color: Colors.black),
                  ),
                  elevation: 0.0,
                  centerTitle: false,
                  actions: [
                    GestureDetector(
                      onTap: () async {
                        await chatRoomsModel.signOut();
                        Navigator.of(context).pushReplacementNamed('/sign_in');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(Icons.exit_to_app),
                      ),
                    )
                  ],
                ),
                body: StreamBuilder(
                  stream: chatRoomsModel.fetchChatRooms(context),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final chatRoomId = snapshot.data.docs[index].id;

                          return FutureBuilder(
                            future: chatRoomsModel.getUser(
                              context,
                              snapshot.data.docs[index]['userUids'],
                            ),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasData) {
                                return ChatRoomTile(
                                  userName: snapshot.data['name'],
                                  chatRoomId: chatRoomId,
                                );
                              }

                              return Container();
                            },
                          );
                        },
                      );
                    }

                    return Container();
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/user_search'),
                ),
              ),
              OverlayLoading(chatRoomsModel.isLoading)
            ],
          );
        },
      ),
    );
  }
}
