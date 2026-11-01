import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';

class CustomConverText extends StatelessWidget {
  const CustomConverText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Row(
          children: [
            SizedBox(width: 16.w),
            Column(
              children: [
                AppText(
                  text: 'Conversation',
                  size: 20.sp,
                  family: FontFamily.tajawalBold,
                ),
                AppText(
                  text: '184 contributions',
                  size: 16.sp,
                  color: Colors.grey,
                  family: FontFamily.tajawalMedium,
                ),
              ],
            ),
            Spacer(),
            AppText(
              text: 'Most relevant',
              size: 16.sp,
              family: FontFamily.tajawalRegular,
              color: Colors.deepPurple,
            ),
            SizedBox(width: 16.w),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
