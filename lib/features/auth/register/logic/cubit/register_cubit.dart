import 'package:alpha/features/auth/register/data/register_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;
  RegisterCubit({required this._registerRepo}) : super(RegisterState.initial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      emit(RegisterState.registerLoading());
      final credential = _registerRepo.register(
        email: emailController.text,
        password: passwordController.text,
      );

      final uid = (await credential).user?.uid;

      await _registerRepo.createUser(
        uid: uid ?? "",
        name: emailController.text.split("@")[0],
        email: emailController.text,
      );

      emit(RegisterState.registerSuccess());
    } catch (e) {
      emit(RegisterState.registerFailure(error: e.toString()));
    }
  }
}
