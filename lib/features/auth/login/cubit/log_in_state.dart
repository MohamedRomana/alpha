import 'package:freezed_annotation/freezed_annotation.dart';
part 'log_in_state.freezed.dart';

@freezed
class LogInState with _$LogInState {
  const factory LogInState.initial() = _Initial;
  const factory LogInState.logInLoading() = LogInLoading;
  const factory LogInState.logInSuccess() = LogInSuccess;
  const factory LogInState.logInFailure({required String error}) = LogInFailure;
}
