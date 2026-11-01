import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';

class CustomProductRates extends StatelessWidget {
  const CustomProductRates({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: '128 VERIFIED REVIEWS',
          size: 12.sp,
          color: Colors.deepPurple,
          family: FontFamily.tajawalBold,
          top: 18.h,
          start: 16.w,
          bottom: 20.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              text: 'Loved in real spaces.',
              size: 25.sp,
              family: FontFamily.tajawalBold,
              start: 16.w,
              bottom: 20.h,
            ),
            Spacer(),
            AppText(
              text: 'see All',
              size: 14.sp,
              color: Colors.grey,
              end: 16.w,
            ),
          ],
        ),

        Container(
          width: 350.w,
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 20.w,
            vertical: 25.h,
          ),
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withAlpha(40),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(width: 1.r, color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(text: '4.9', size: 50.sp, family: FontFamily.tajawalBold),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    initialRating: double.parse('4.9'),
                    maxRating: 5,
                    isHalfAllowed: true,
                    halfFilledIcon: Icons.star_half,
                    size: 18.sp,
                  ),
                  AppText(
                    top: 10.h,
                    bottom: 20.h,
                    text: 'Based on 128 reviews',
                    size: 12.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              Row(
                children: [
                  AppText(text: '5', end: 10.w, size: 12.sp),
                  SizedBox(
                    width: 280.w,
                    child: ProgressIndicatorTheme(
                      data: ProgressIndicatorTheme.of(context),
                      child: LinearProgressIndicator(
                        value: 0.9,
                        minHeight: 5.h,
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10.r),
                        backgroundColor: Colors.grey.withAlpha(50),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  AppText(text: '4', end: 10.w, size: 12.sp),
                  SizedBox(
                    width: 280.w,
                    child: ProgressIndicatorTheme(
                      data: ProgressIndicatorTheme.of(context),
                      child: LinearProgressIndicator(
                        value: 0.5,
                        minHeight: 5.h,
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10.r),
                        backgroundColor: Colors.grey.withAlpha(50),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              Row(
                children: [
                  AppText(text: '3', end: 10.w, size: 12.sp),
                  SizedBox(
                    width: 280.w,
                    child: ProgressIndicatorTheme(
                      data: ProgressIndicatorTheme.of(context),
                      child: LinearProgressIndicator(
                        value: 0.2,
                        minHeight: 5.h,
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10.r),
                        backgroundColor: Colors.grey.withAlpha(50),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 40.h),
        ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 25.h),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 16.w),
                CircleAvatar(
                  radius: 50.r,
                  backgroundImage: AssetImage(Assets.img.img.path),
                ),
                SizedBox(width: 14.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180.w,
                      child: AppText(
                        text: 'User Name',
                        size: 18.sp,
                        family: FontFamily.tajawalBold,
                      ),
                    ),
                    SizedBox(
                      width: 180.w,
                      child: AppText(
                        text: 'Verified purchase',
                        size: 12.sp,
                        color: Colors.greenAccent,
                        bottom: 12.h,
                      ),
                    ),

                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      initialRating: double.parse('4.9'),
                      maxRating: 5,
                      isHalfAllowed: true,
                      halfFilledIcon: Icons.star_half,
                      size: 18.sp,
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 180.w,
                      child: AppText(
                        lines: 100,
                        text:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        size: 14.sp,
                        family: FontFamily.tajawalRegular,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: 180.w,
                      padding: EdgeInsetsDirectional.symmetric(
                        vertical: 10.h,
                        horizontal: 12.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(width: 0.5.r, color: Colors.grey),
                      ),
                      child: AppText(
                        text:
                            'Frame Eight responded: Thank you for bringing Luma into your space.',
                        size: 12.sp,
                        color: Colors.grey,
                        lines: 5,
                        family: FontFamily.tajawalRegular,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz, size: 20.sp, color: Colors.grey),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

