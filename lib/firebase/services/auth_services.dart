import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword( // signInWithEmailAndPassword method used in login page is defined here
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        //When a user successfully logs in, Firebase returns a UserCredential object, which contains:User information → user (Email, UID, Display Name, etc.)Login method → (Email/Password, Google, Facebook, etc.)Token data → Used for authentication
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('User signed out successfully.');
    } catch (e) {
      print('Error during sign-out: ${e.toString()}');
    }
  }
}
