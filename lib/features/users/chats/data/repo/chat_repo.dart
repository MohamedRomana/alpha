import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  String? get currentUid => currentUser?.uid;

  // =========================
  // USERS
  // =========================

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return _firebaseFirestore.collection('users').snapshots();
  }

  // =========================
  // CHATS
  // =========================

  Stream<List<ChatModel>> getChats() {
    return _firebaseFirestore
        .collection('chats')
        .where('participants', arrayContains: currentUid)
        .orderBy('lastMessageTime', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatModel.fromFirestore(doc))
              .toList();
        });
  }

  // =========================
  // CREATE / GET CHAT
  // =========================

  Future<String> getOrCreateChat({required String otherUid}) async {
    final result = await _firebaseFirestore
        .collection('chats')
        .where('participants', arrayContains: currentUid)
        .get();

    for (final doc in result.docs) {
      final participants = List<String>.from(doc.data()['participants'] ?? []);

      if (participants.contains(otherUid)) {
        return doc.id;
      }
    }

    final chatRef = _firebaseFirestore.collection('chats').doc();

    await chatRef.set({
      'participants': [currentUid, otherUid],
      'lastMessage': '',
      'lastMessageSenderId': '',
      'lastMessageTime': null,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return chatRef.id;
  }

  // =========================
  // MESSAGES
  // =========================

  Stream<List<MessageModel>> getMessages({required String chatId}) {
    return _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromFirestore(doc))
              .toList();
        });
  }

  // =========================
  // SEND MESSAGE
  // =========================

  Future<void> sendMessage({
    required String chatId,
    required String text,
  }) async {
    final chatRef = _firebaseFirestore.collection('chats').doc(chatId);

    final messageRef = chatRef.collection('messages').doc();

    final batch = _firebaseFirestore.batch();

    batch.set(messageRef, {
      'senderId': currentUid,
      'text': text,
      'type': 'text',
      'createdAt': FieldValue.serverTimestamp(),
    });

    batch.update(chatRef, {
      'lastMessage': text,
      'lastMessageSenderId': currentUid,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  // =========================
  // Log OUt
  // =========================
  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }
}
