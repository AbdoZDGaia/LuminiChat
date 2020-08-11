import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(usernameSearchString) async {
    return await Firestore.instance
        .collection("Users")
        .where("email", isEqualTo: usernameSearchString)
        // .where("searchIndex", arrayContains: usernameSearchString)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("Users").add(userMap);
  }
}
