import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Stream<User?> get authStatus => _auth.authStateChanges();

  Future<User?> loginwithEmailandPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> registerwithEmailandPassword(
      String email, String password, String fullname, String username) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        await _users.doc(credential.user!.uid).set({
          'username': username,
          'fullname': fullname,
          'email': email,
        });
      }
      return credential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
