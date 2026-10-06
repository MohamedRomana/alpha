import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/helper/extentions.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomRegisterLogin extends StatelessWidget {
  const CustomRegisterLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Stack(
          children: [
            Divider(
              color: Colors.white,
              height: 50.h,
              thickness: 1.h,
              indent: 20.w,
              endIndent: 20.w,
            ),
            PositionedDirectional(
              start: 150.w,
              end: 150.w,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 40.w,
                    width: 40.w,
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                  AppText(
                    top: 5.h,
                    text: LocaleKeys.or.tr(),
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: LocaleKeys.alreadyHaveAccount.tr(),
              size: 18.sp,
              color: Colors.white,
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                context.pushNamedAndRemoveUntil(
                  Routes.login,
                  predicate: (Route<dynamic> route) {
                    return false;
                  },
                );
              },
              child: AppText(
                text: LocaleKeys.login.tr(),
                size: 18.sp,
                color: AppColors.dangerColor,
                family: FontFamily.tajawalBold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
