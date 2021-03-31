import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat/chat_room_screen.dart';
import 'package:flutter_chat_app/theme/theme.dart';

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomTile({@required this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Colors.black26,
      closedColor: Colors.black26,
      closedElevation: 1,
      transitionType: ContainerTransitionType.fade,
      transitionDuration: Duration(milliseconds: 700),
      openBuilder: (BuildContext context, action) => ChatRoomScreen(chatRoomId),
      closedBuilder: (context, action) {
        return Container(
          color: Colors.black26,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: CustomTheme.colorAccent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    userName.substring(0, 1),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
