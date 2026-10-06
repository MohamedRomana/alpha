import 'package:alpha/features/auth/login/cubit/log_in_cubit.dart';
import 'package:alpha/features/auth/login/cubit/log_in_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/extentions.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomLoginFields extends StatefulWidget {
  const CustomLoginFields({super.key});

  @override
  State<CustomLoginFields> createState() => _CustomLoginFieldsState();
}

class _CustomLoginFieldsState extends State<CustomLoginFields> {
  late bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LogInState>(
      listener: (context, state) {
        state.mapOrNull(
          logInSuccess: (_) {
            showFlashMessage(
              message: LocaleKeys.loginSuccess.tr(),
              type: FlashMessageType.success,
              context: context,
            );
            context.pushNamedAndRemoveUntil(
              Routes.chats,
              predicate: (Route<dynamic> route) {
                return false;
              },
            );
            debugPrint("CustomLoginFields: login success");
          },
          logInFailure: (error) {
            showFlashMessage(
              message: error.error,
              type: FlashMessageType.error,
              context: context,
            );
            debugPrint("CustomLoginFields: login error: $error");
          },
        );
      },
      builder: (context, state) {
        return Form(
          key: context.read<LogInCubit>().formKey,
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
                color: Colors.white.withAlpha(100),
                filled: true,
                borderColorr: Colors.white,
                enabledBorderColor: Colors.white,
                controller: context.read<LogInCubit>().emailController,
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
                inputType: TextInputType.emailAddress,
                color: Colors.white.withAlpha(100),
                controller: context.read<LogInCubit>().passwordController,
                filled: true,
                borderColorr: Colors.white,
                enabledBorderColor: Colors.white,
                hintColor: Colors.white.withAlpha(150),
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
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.passwordValidate.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: 35.h),
              Center(
                child: AppButton(
                  onPressed: () {
                    if (context
                        .read<LogInCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<LogInCubit>().logIn();
                    }
                  },
                  child: state is LogInLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : AppText(
                          text: LocaleKeys.login.tr(),
                          size: 20.sp,
                          color: Colors.white,
                          family: FontFamily.tajawalBold,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
