import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';

class CustomAddPost extends StatelessWidget {
  const CustomAddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(width: 0.5.r, color: Colors.grey),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(500.r),
            child: Image.asset(
              Assets.img.img.path,
              height: 40.w,
              width: 40.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 250.w,
            child: AppText(
              start: 12.w,
              text: 'Share an idea, moment, or discovery…',
              lines: 2,
              size: 12.sp,
            ),
          ),
          Icon(Icons.image_outlined, size: 25.sp, color: Colors.grey),
        ],
      ),
    );
  }
}
