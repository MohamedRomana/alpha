import 'package:alpha/core/widgets/app_text.dart';
import 'package:alpha/gen/assets.gen.dart';
import 'package:alpha/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRelatedObjects extends StatelessWidget {
  const CustomRelatedObjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50.h),

        AppText(
          text: 'FROM THE SAME STUDIO',
          size: 14.sp,
          bottom: 16.h,
          start: 16.w,
          color: Colors.deepPurple,
          family: FontFamily.tajawalBold,
        ),
        AppText(
          text: 'Related objects',
          size: 25.sp,
          family: FontFamily.tajawalBold,
          start: 16.w,
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 450.h,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
            separatorBuilder: (context, index) => SizedBox(width: 25.w),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.asset(
                          Assets.img.img.path,
                          height: 300.h,
                          width: 200.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 300.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withAlpha(100),
                              Colors.black.withAlpha(200),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  AppText(
                    text: 'FURNITURE',
                    size: 12.sp,
                    color: Colors.grey,
                    family: FontFamily.tajawalBold,
                    bottom: 10.h,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: 'Arc Study Chair',
                            size: 14.sp,
                            family: FontFamily.tajawalBold,
                          ),

                          AppText(text: '£620', size: 12.sp, bottom: 10.h),
                        ],
                      ),
                      SizedBox(width: 50.w),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.bookmark_outline, size: 25.h),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18.sp),
                          AppText(
                            start: 5.w,
                            text: '4.9',
                            size: 12.sp,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                      SizedBox(width: 70.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withAlpha(40),
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(width: 0.5.r, color: Colors.grey),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.add, size: 16.sp),
                            AppText(
                              text: 'Add',
                              size: 16.sp,
                              family: FontFamily.tajawalMedium,
                              start: 5.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
