import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
