import 'package:alpha/core/widgets/animation_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import 'app_text.dart';
import 'logo_animations.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  const CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      padding: EdgeInsetsDirectional.only(top: 30.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(20.r),
          bottomEnd: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha(50),
            spreadRadius: 5.r,
            blurRadius: 10.r,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 20.w),
          AnimatedGradientCircle(
            child: AlphaLogoFX(
              style: LogoAnimationStyle.auth,
              child: Image.asset(
                Assets.img.logo.path,
                width: 30.w,
                height: 30.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 20.w),
          AppText(
            text: title ?? "Alpha",
            size: 20.sp,
            fontStyle: FontStyle.italic,
            family: FontFamily.tajawalBold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
