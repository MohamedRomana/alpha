import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';

class CustomConversList extends StatelessWidget {
  const CustomConversList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
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
                    size: 16.sp,
                    family: FontFamily.tajawalBold,
                    bottom: 12.h,
                  ),
                ),
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
                SizedBox(
                  width: 180.w,
                  child: AppText(
                    text: '12m · Reply · 24 reactions',
                    size: 12.sp,
                    top: 10.h,
                    color: Colors.grey,
                    family: FontFamily.tajawalRegular,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                size: 20.sp,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }
}
