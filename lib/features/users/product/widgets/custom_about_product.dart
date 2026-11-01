import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';

class CustomAboutProduct extends StatelessWidget {
  const CustomAboutProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          start: 16.w,
          text: 'FRAME EIGHT / LIGHTING',
          size: 12.sp,
          family: FontFamily.tajawalBold,
          color: Colors.deepPurple,
          bottom: 10.h,
        ),
        AppText(
          start: 16.w,
          text: 'Luma Object Lamp',
          size: 25.sp,
          family: FontFamily.tajawalBold,
          bottom: 15.h,
        ),
        Row(
          children: [
            SizedBox(width: 16.w),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20.h),
                AppText(
                  text: '4.5',
                  size: 14.sp,
                  family: FontFamily.tajawalBold,
                  color: Colors.amber,
                ),
              ],
            ),
            AppText(
              start: 16.w,
              text: ' (200 reviews)',
              size: 14.sp,
              family: FontFamily.tajawalBold,
              decoration: TextDecoration.underline,
            ),
            AppText(
              start: 16.w,
              text: 'In stock · 12 available',
              size: 14.sp,
              family: FontFamily.tajawalBold,
              color: Colors.grey,
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            AppText(
              text: '£248',
              start: 16.w,
              size: 25.sp,
              family: FontFamily.tajawalBold,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                AppText(
                  text: '£248',
                  size: 20.sp,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  family: FontFamily.tajawalMedium,
                  start: 16.w,
                  end: 20.w,
                ),
                PositionedDirectional(
                  bottom: 15.h,
                  child: Container(
                    width: 50.w,
                    height: 1.h,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(50),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: AppText(
                  text: '20% off',
                  size: 14.sp,
                  color: Colors.red,
                  family: FontFamily.tajawalMedium,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 343.w,
          child: AppText(
            text:
                'A sculptural table light shaped around quiet, indirect illumination. Cast from recycled aluminium and finished by hand in London.',
            lines: 5,
            color: Colors.grey,
            size: 14.sp,
            family: FontFamily.tajawalMedium,
            start: 16.w,
            top: 10.h,
            bottom: 20.h,
          ),
        ),
      ],
    );
  }
}
