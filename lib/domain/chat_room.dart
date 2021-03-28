class ChatRoom {
  final String documentId;
  final List<dynamic> userUids;

  ChatRoom({this.documentId, this.userUids});

  ChatRoom.fromJson(Map<String, dynamic> json)
      : documentId = json['documentId'],
        userUids = json['userUids'].map((id) => id.toString()).toList();
}
