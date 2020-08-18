import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(usernameSearchString) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where("searchIndex", arrayContains: usernameSearchString)
        .get();
  }

  getUserByUserEmail(userEmail) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where("email", isEqualTo: userEmail.toString().toLowerCase())
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("Users").add(userMap);
  }

  createChatRoom(String chatRoomId, chatroomMap) {
    return FirebaseFirestore.instance
        .collection("ChatRooms")
        .doc(chatRoomId)
        .set(chatroomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  isRoomDuplicated(String invertedChatRoomId) {
    return FirebaseFirestore.instance
        .collection("ChatRooms")
        .where("chatRoomId", isEqualTo: invertedChatRoomId).get()
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessageByRoomId(
      String chatRoomId, Map<String, dynamic> messageMap) {
    FirebaseFirestore.instance
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection('Chats')
        .add(messageMap)
        .catchError((e) {
      print('${e.toString()}');
    });
  }

  getConversationMessagesByRoomId(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection('Chats')
        .orderBy('Time', descending: true)
        .snapshots();
  }
}
