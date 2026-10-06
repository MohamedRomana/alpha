import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/extentions.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomLoginFields extends StatelessWidget {
  const CustomLoginFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          filled: true,
          borderColorr: Colors.white,
          enabledBorderColor: Colors.white,
          hintColor: Colors.white.withAlpha(150),
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
              context.pushNamedAndRemoveUntil(
                Routes.chats,
                predicate: (Route<dynamic> route) {
                  return false;
                },
              );
            },
            child: AppText(
              text: LocaleKeys.login.tr(),
              size: 20.sp,
              color: Colors.white,
              family: FontFamily.tajawalBold,
            ),
          ),
        ),
      ],
    );
  }
}
