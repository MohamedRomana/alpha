import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text.dart';
import '../../../../gen/fonts.gen.dart';

class CustomWelcome extends StatelessWidget {
  const CustomWelcome({
    super.key,
    required this.day,
    required this.time,
    required this.period,
    required this.name,
    required this.greeting,
  });

  final String day;
  final String time;
  final String period;
  final String? name;
  final String greeting;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        AppText(
          text: '$day  :  $time ',
          start: 16.sp,
          size: 16.sp,
          family: FontFamily.tajawalMedium,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        ),
        AppText(
          text: '$greeting, ${name ?? ''}',
          start: 16.sp,
          size: 25.sp,
          family: FontFamily.tajawalBold,
        ),
      ],
    );
  }
}
