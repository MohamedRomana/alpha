import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/chat_repo.dart';
import 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final ChatRepo _repo;
  ChatsCubit(this._repo) : super(ChatsState.initial());

  Future<void> logOut() async {
    try {
      emit(ChatsState.logOutLoading());
      final uid = _repo.currentUser?.uid;
      await _repo.logOut();
      debugPrint('Logged out user: $uid');
      emit(ChatsState.logOutSuccess());
    } catch (e) {
      emit(ChatsState.logOutFailure(message: e.toString()));
    }
  }
}
