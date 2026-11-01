import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_input.dart';
import '../../../../gen/assets.gen.dart';

class CustomJoinConv extends StatelessWidget {
  const CustomJoinConv({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16.w),
        CircleAvatar(
          radius: 20.r,
          backgroundImage: AssetImage(Assets.img.img.path),
        ),
        SizedBox(
          width: 280.w,
          height: 50.h,
          child: AppInput(
            hint: 'join the conversation',
            color: Colors.grey[900],
            filled: true,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Icon(Icons.send_outlined, size: 30.sp),
        ),
      ],
    );
  }
}
