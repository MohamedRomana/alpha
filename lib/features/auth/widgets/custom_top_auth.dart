import 'package:alpha/core/widgets/logo_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';

class CustomTopAuth extends StatelessWidget {
  final String title;
  const CustomTopAuth({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100.h),
        AlphaLogoFX(
          style: LogoAnimationStyle.auth,
          child: Image.asset(
            Assets.img.logo.path,
            width: 250.w,
            height: 250.w,
            fit: BoxFit.cover,
          ),
        ),

        AppText(
          text: title,
          size: 25.sp,
          color: Colors.white,
          family: FontFamily.tajawalBold,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
