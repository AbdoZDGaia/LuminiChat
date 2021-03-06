import 'package:firebase_auth/firebase_auth.dart';
import 'package:lumini_chat/models/users.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser _userFromFirebaseUser(User firebaseUser) =>
      firebaseUser != null ? AppUser(userId: firebaseUser.uid) : null;
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.toLowerCase().trimRight(), password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.toLowerCase().trimRight(), password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(
          email: email.toLowerCase().trimRight());
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}

final AuthMethods authMethods = AuthMethods();
