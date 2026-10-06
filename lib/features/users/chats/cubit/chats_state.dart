import 'package:freezed_annotation/freezed_annotation.dart';
part 'chats_state.freezed.dart';

@freezed
class ChatsState with _$ChatsState {
  const factory ChatsState.initial() = _Initial;
  const factory ChatsState.logOutLoading() = LogOutLoading;
  const factory ChatsState.logOutSuccess() = LogOutSuccess;
  const factory ChatsState.logOutFailure({required String message}) =
      LogOutFailure;
}
