import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/login_repo.dart';
import 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final LogInRepo _logInRepo;
  LogInCubit({required this._logInRepo}) : super(LogInState.initial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> logIn() async {
    try {
      emit(LogInState.logInLoading());
      final credential = await _logInRepo.logIn(
        email: emailController.text,
        password: passwordController.text,
      );
      final uid = credential.user?.uid;

      if (uid != null) {
        emit(LogInState.logInSuccess());
      } else {
        emit(LogInState.logInFailure(error: "User ID is null"));
      }
    } catch (e) {
      emit(LogInState.logInFailure(error: e.toString()));
    }
  }
}
