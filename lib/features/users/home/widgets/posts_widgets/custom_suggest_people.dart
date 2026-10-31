import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';

class CustomSuggestPeople extends StatelessWidget {
  const CustomSuggestPeople({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'NEW CONNECTIONS',
                  size: 16.sp,
                  color: Colors.grey,
                ),
                AppText(
                  text: 'People in your orbit',
                  size: 20.sp,
                  family: FontFamily.tajawalBold,
                ),
              ],
            ),
            Spacer(),
            AppText(text: 'see all', size: 14.sp, color: Colors.deepPurple),
            SizedBox(width: 16.w),
          ],
        ),
        SizedBox(
          height: 220.h,
          child: ListView.separated(
            itemCount: 10,
            padding: EdgeInsetsDirectional.only(
              start: 16.w,
              end: 16.w,
              top: 12.h,
              bottom: 12.h,
            ),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              return Container(
                width: 180.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(30),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: Colors.grey.withAlpha(100)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 10.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(500.r),
                      child: Image.asset(
                        Assets.img.img.path,
                        height: 60.w,
                        width: 60.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 180.w,
                          child: AppText(
                            text: 'Nia Okafor',
                            textAlign: TextAlign.center,
                            size: 16.sp,
                            family: FontFamily.tajawalBold,
                            top: 10.h,
                          ),
                        ),
                        SizedBox(
                          width: 180.w,
                          child: AppText(
                            text: 'Creative technologist',
                            textAlign: TextAlign.center,
                            size: 12.sp,
                            color: Colors.grey,
                            bottom: 10.h,
                          ),
                        ),
                      ],
                    ),
                    AppButton(
                      onPressed: () {},
                      height: 30.h,
                      width: 150.w,
                      color: Colors.grey[900],
                      borderColor: Colors.white,
                      borderWidth: 0.3.w,
                      child: AppText(
                        text: 'Connect',
                        size: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
