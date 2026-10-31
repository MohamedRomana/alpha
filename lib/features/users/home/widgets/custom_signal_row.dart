import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';

class CustomSignalRow extends StatelessWidget {
  const CustomSignalRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          text: 'YOUR SIGNAL',
          size: 16.sp,
          start: 16.w,
          color: Colors.grey,
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.bubble_chart, size: 16.sp, color: Colors.grey),
            AppText(
              text: 'created for you',
              size: 16.sp,
              start: 5.w,
              end: 16.w,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}
