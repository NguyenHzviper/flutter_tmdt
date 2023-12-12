import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register a new user with email and password
  Future<String?> registerUser(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return the user's unique ID (UID)
      return userCredential.user?.uid;
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  // Log in a user with email and password
  Future<String?> loginUser(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return the user's unique ID (UID)
      return userCredential.user?.uid;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }
}
