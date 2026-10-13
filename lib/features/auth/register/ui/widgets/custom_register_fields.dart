// ignore_for_file: use_build_context_synchronously

import 'package:alpha/core/helper/extentions.dart';
import 'package:alpha/core/widgets/flash_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomRegisterFields extends StatefulWidget {
  const CustomRegisterFields({super.key});

  @override
  State<CustomRegisterFields> createState() => _CustomRegisterFieldsState();
}

class _CustomRegisterFieldsState extends State<CustomRegisterFields> {
  late bool showPass = false;
  late bool showConfirmPass = false;

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmedController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: LocaleKeys.email.tr(),
            size: 16.sp,
            color: Colors.white,
            bottom: 10.h,
            start: 16.w,
          ),
          AppInput(
            start: 16.w,
            hint: LocaleKeys.yourEmail.tr(),
            inputType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value ?? "";
            },
            color: Colors.white.withAlpha(100),
            filled: true,
            controller: _emailController,
            borderColorr: Colors.white,
            enabledBorderColor: AppColors.secondray,
            focusedBorderColor: Colors.white,
            hintColor: Colors.white.withAlpha(150),
            validate: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.yourEmailValidate.tr();
              }
              return null;
            },
          ),

          SizedBox(height: 20.h),
          AppText(
            text: LocaleKeys.password.tr(),
            size: 16.sp,
            color: Colors.white,
            bottom: 10.h,
            start: 16.w,
          ),
          AppInput(
            start: 16.w,
            hint: LocaleKeys.enter_password.tr(),
            controller: _passwordController,
            inputType: TextInputType.visiblePassword,
            onChanged: (value) {
              password = value ?? "";
            },
            color: Colors.white.withAlpha(100),
            filled: true,
            secureText: !showPass,
            suffixIcon: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() {
                  showPass = !showPass;
                });
              },
              child: Icon(
                showPass == true ? Icons.visibility : Icons.visibility_off,
                color: Colors.white.withAlpha(150),
              ),
            ),
            borderColorr: Colors.white,
            hintColor: Colors.white.withAlpha(150),
            validate: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.passwordValidate.tr();
              }
              return null;
            },
          ),
          SizedBox(height: 20.h),
          AppText(
            text: LocaleKeys.confirmPassword.tr(),
            size: 16.sp,
            color: Colors.white,
            bottom: 10.h,
            start: 16.w,
          ),
          AppInput(
            start: 16.w,
            hint: LocaleKeys.enter_password.tr(),
            controller: _passwordConfirmedController,
            inputType: TextInputType.visiblePassword,
            color: Colors.white.withAlpha(100),
            filled: true,
            secureText: !showConfirmPass,
            suffixIcon: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() {
                  showConfirmPass = !showConfirmPass;
                });
              },
              child: Icon(
                showConfirmPass == true
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.white.withAlpha(150),
              ),
            ),
            borderColorr: Colors.white,
            hintColor: Colors.white.withAlpha(150),
            validate: (value) {
              if (value!.isEmpty ||
                  _passwordController != _passwordConfirmedController) {
                LocaleKeys.passwordDoesNotMatch.tr();
              }
              return null;
            },
          ),

          SizedBox(height: 35.h),
          Center(
            child: AppButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                if (_formKey.currentState!.validate()) {
                  try {
                    await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    context.pushNamedAndRemoveUntil(
                      Routes.chatDetails,
                      predicate: (_) => false,
                      arguments: email.split('@').first,
                    );
                    showFlashMessage(
                      message: LocaleKeys.signUpSuccess.tr(),
                      type: FlashMessageType.success,
                      context: context,
                    );
                    setState(() {
                      isLoading = false;
                    });
                  } catch (e) {
                    showFlashMessage(
                      message: e.toString(),
                      type: FlashMessageType.error,
                      context: context,
                    );
                    setState(() {
                      isLoading = false;
                    });
                  }
                }
              },
              child: isLoading == true
                  ? CircularProgressIndicator(color: Colors.white)
                  : AppText(
                      text: LocaleKeys.sign_up.tr(),
                      size: 20.sp,
                      color: Colors.white,
                      family: FontFamily.tajawalBold,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
