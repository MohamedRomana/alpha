import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';

class CustomProductObjectImage extends StatelessWidget {
  const CustomProductObjectImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.img.img.path,
          width: double.infinity,
          height: 500.h,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 500.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withAlpha(10),
                Colors.black.withAlpha(100),
                Colors.black.withAlpha(200),
                Colors.black.withAlpha(200),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'THE OBJECT',
                size: 12.sp,
                color: Colors.grey,
                family: FontFamily.tajawalBold,
                start: 16.w,
                bottom: 15.h,
              ),
              SizedBox(
                width: 300.w,
                child: AppText(
                  text: 'Designed to make light feel slower.',
                  size: 35.sp,
                  color: Colors.white,
                  lines: 2,
                  family: FontFamily.tajawalBold,
                  start: 16.w,
                  bottom: 10.h,
                ),
              ),
              SizedBox(
                width: 350.w,
                child: AppText(
                  text:
                      'Every Luma lamp is assembled and finished by hand in Frame Eight’s London studio.',
                  size: 10.sp,
                  color: Colors.grey,
                  lines: 2,
                  start: 16.w,
                  end: 16.w,
                  bottom: 15.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
