import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../widgets/custom_top_auth.dart';
import 'widgets/login_fields.dart';
import 'widgets/login_new_user.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});
  Future<void> _confirmExit(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit(context);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomTopAuth(title: LocaleKeys.login.tr()),
              CustomLoginFields(),
              CustomLoginNewUser(),
            ],
          ),
        ),
      ),
    );
  }
}
