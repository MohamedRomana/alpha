import 'package:alpha/core/widgets/flash_message.dart';
import 'package:alpha/features/auth/register/logic/cubit/register_cubit.dart';
import 'package:alpha/features/auth/register/logic/cubit/register_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        state.mapOrNull(
          registerSuccess: (_) {
            showFlashMessage(
              message: LocaleKeys.signUpSuccess.tr(),
              type: FlashMessageType.success,
              context: context,
            );
            debugPrint("CustomRegisterFields: register success");
          },

          registerFailure: (error) {
            showFlashMessage(
              message: error.error,
              type: FlashMessageType.error,
              context: context,
            );
            debugPrint("CustomRegisterFields: register error: $error");
          },
        );
      },
      builder: (context, state) {
        return Form(
          key: context.read<RegisterCubit>().formKey,
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
                controller: context.read<RegisterCubit>().emailController,
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
                controller: context.read<RegisterCubit>().passwordController,
                inputType: TextInputType.visiblePassword,
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
                controller: context
                    .read<RegisterCubit>()
                    .confirmPasswordController,
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
                  if (context.read<RegisterCubit>().passwordController.text !=
                      context
                          .read<RegisterCubit>()
                          .confirmPasswordController
                          .text) {
                    return LocaleKeys.passwordDoesNotMatch.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: 35.h),
              Center(
                child: AppButton(
                  onPressed: () {
                    if (context
                        .read<RegisterCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<RegisterCubit>().register();
                    }
                  },
                  child: state is RegisterLoading
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
      },
    );
  }
}
