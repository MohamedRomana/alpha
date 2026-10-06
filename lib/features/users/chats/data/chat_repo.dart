import 'package:firebase_auth/firebase_auth.dart';

class ChatRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  
  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }
}
