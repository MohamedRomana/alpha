import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.registerLoading() = RegisterLoading;
  const factory RegisterState.registerSuccess() = RegisterSuccess;
  const factory RegisterState.registerFailure({required String error}) = RegisterFailure;
}
