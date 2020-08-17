import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(usernameSearchString) async {
    return await Firestore.instance
        .collection("Users")
        .where("searchIndex", arrayContains: usernameSearchString)
        .getDocuments();
  }

  getUserByUserEmail(userEmail) async {
    return await Firestore.instance
        .collection("Users")
        .where("email", isEqualTo: userEmail.toString().toLowerCase())
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("Users").add(userMap);
  }

  createChatRoom(String chatRoomId, chatroomMap) {
    return Firestore.instance
        .collection("ChatRooms")
        .document(chatRoomId)
        .setData(chatroomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessageByRoomId(
      String chatRoomId, Map<String, dynamic> messageMap) {
    Firestore.instance
        .collection('ChatRooms')
        .document(chatRoomId)
        .collection('Chats')
        .add(messageMap)
        .catchError((e) {
      print('${e.toString()}');
    });
  }

  getConversationMessagesByRoomId(String chatRoomId) {
    return Firestore.instance
        .collection('ChatRooms')
        .document(chatRoomId)
        .collection('Chats')
        .orderBy('Time', descending: true)
        .snapshots();
  }
}
