import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/fonts.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../constants/colors.dart';
import 'app_text.dart';

Future<void> confirmExit(BuildContext context) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black,
        shadowColor: Colors.white,
        elevation: 2.r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: AppText(
          text: LocaleKeys.doYouWantToLeaveThisApp.tr(),
          size: 16.sp,
          fontWeight: FontWeight.w700,
          family: FontFamily.tajawalBold,
          color: Colors.white,
        ),
        content: AppText(
          text: LocaleKeys.areYouSure.tr(),
          color: Colors.white,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: AppText(
              text: LocaleKeys.no.tr(),
              color: AppColors.dangerColor,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: AppText(
              text: LocaleKeys.yes.tr(),
              color: AppColors.onlineColor,
            ),
          ),
        ],
      ),
    );
    if (leave == true) SystemNavigator.pop();
  }
