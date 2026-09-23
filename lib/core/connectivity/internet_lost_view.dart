import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../constants/colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text.dart';
import '../../gen/fonts.gen.dart';
import '../../generated/locale_keys.g.dart';

/// شاشة بتظهر فوق التطبيق كله لما النت يقطع: لوتي + رسالة + زرار إعادة محاولة.
/// بتختفي تلقائيًا أول ما النت يرجع (من غير ما المستخدم يقفل التطبيق).
class InternetLostView extends StatelessWidget {
  final Future<void> Function()? onRetry;
  final bool retrying;
  const InternetLostView({super.key, this.onRetry, this.retrying = false});

  @override
  Widget build(BuildContext context) {
    // Material عشان يبقى فيه خلفية وتفادي أي شفافية فوق الشاشة اللي تحته.
    return Material(
      color: AppColors.backColor,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/img/internet_lost.json',
                  height: 240.w,
                  width: 240.w,
                  repeat: true,
                  animate: true,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 8.h),
                AppText(
                  text: LocaleKeys.no_internet_title.tr(),
                  size: 20.sp,
                  textAlign: TextAlign.center,
                  color: AppColors.primary,
                  family: FontFamily.tajawalBold,
                  fontWeight: FontWeight.w700,
                  bottom: 10.h,
                ),
                AppText(
                  text: LocaleKeys.no_internet_msg.tr(),
                  size: 14.sp,
                  textAlign: TextAlign.center,
                  color: const Color(0xff6D6161),
                  family: FontFamily.tajawalRegular,
                  fontWeight: FontWeight.w400,
                  bottom: 24.h,
                  lines: 3,
                ),
                if (onRetry != null)
                  AppButton(
                    width: 260.w,
                    color: AppColors.secondray,
                    onPressed: () {
                      if (retrying) return;
                      onRetry!();
                    },
                    child: retrying
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : AppText(
                            text: LocaleKeys.retry.tr(),
                            size: 16.sp,
                            color: Colors.white,
                            family: FontFamily.tajawalBold,
                            fontWeight: FontWeight.w700,
                          ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
