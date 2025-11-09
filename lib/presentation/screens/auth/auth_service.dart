import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //======= Auth instance =========
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //======== singn in ===============
  Future<UserCredential> signInwithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //========= sign up =============
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  //======== sign out =============
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //========== errors =============
}
