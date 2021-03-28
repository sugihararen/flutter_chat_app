import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/chat/user_search_model.dart';
import 'package:flutter_chat_app/repositories/auth_repository.dart';
import 'package:flutter_chat_app/widget/button/primary_button.dart';
import 'package:provider/provider.dart';

class UserSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserSearchModel>(
      create: (_) => UserSearchModel(),
      child: Consumer<UserSearchModel>(
        builder: (BuildContext context, UserSearchModel userSearchModel,
            Widget child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('SEARCH USER'),
            ),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  color: Color(0x54FFFFFF),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: userSearchModel.searchEditingController,
                          decoration: InputDecoration(
                            hintText: "Search UserName...",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => userSearchModel.searchUser(context),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: userSearchModel.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (userSearchModel.users[index]['email'] ==
                        Provider.of<AuthRepository>(context, listen: false)
                            .currentUser
                            .email) return Container();

                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userSearchModel.users[index]['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                userSearchModel.users[index]['email'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          PrimaryButton(
                            text: "Message",
                            onPressed: () async {
                              final chatRoomId =
                                  await userSearchModel.sendMessage(
                                      context, userSearchModel.users[index].id);

                              Navigator.of(context).pushReplacementNamed(
                                  '/chat_room',
                                  arguments: chatRoomId);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
