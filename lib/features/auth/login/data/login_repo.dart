import 'package:firebase_auth/firebase_auth.dart';

class LogInRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
